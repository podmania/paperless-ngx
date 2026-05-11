{
  description = "paperless-ngx distroless image using nix2container";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix2container.url = "github:nlewo/nix2container";
    base.url = "github:podmania/base";
  };

  outputs = { self, nixpkgs, nix2container, base }: let
    system = builtins.currentSystem;
    pkgs = nixpkgs.legacyPackages.${system};
    n2c = nix2container.outputs.packages.${system}.nix2container;
    version = "2.20.15";
    srcHash = "sha256-Czh4Knel0IIHsTc3kEnp1153Kv+3721GRCbTYTkeCDg=";
    src = pkgs.fetchFromGitHub {
      owner = "paperless-ngx";
      repo = "paperless-ngx";
      rev = "v${version}";
      hash = srcHash;
    };
    frontendPkg = pkgs.paperless-ngx.frontend.overrideAttrs (old: {
      inherit version src;
    });
    pkg = pkgs.paperless-ngx.overrideAttrs (old: {
      inherit version src;
      installPhase = builtins.replaceStrings
        [ (builtins.toString pkgs.paperless-ngx.frontend) ]
        [ (builtins.toString frontendPkg) ]
        old.installPhase;
    });
    imageConfig = {
      ExposedPorts = {
        "8000/tcp" = {};
      };
      Volumes = {
        "/data" = {};
        "/media" = {};
        "/export" = {};
        "/consume" = {};
      };
      Cmd = [ "${pkg}/bin/paperless-ngx" ];
    };
  in {
    packages.${system} = {
      paperless-ngx-image = n2c.buildImage {
        name = "paperless-ngx";
        tag = "latest";
        fromImage = base.packages.${system}.base-image;
        config = imageConfig;
      };

      paperless-ngx-debug-image = n2c.buildImage {
        name = "paperless-ngx";
        tag = "latest-debug";
        fromImage = base.packages.${system}.base-debug-image;
        config = imageConfig;
      };

      paperless-ngx = pkg;

      default = self.packages.${system}.paperless-ngx-image;
    };

    paperless-ngxVersion = version;
  };
}
