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
      Cmd = [ "${pkgs.paperless-ngx}/bin/paperless-ngx" ];
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

      paperless-ngx = pkgs.paperless-ngx;

      default = self.packages.${system}.paperless-ngx-image;
    };
    
    paperless-ngxVersion = pkgs.paperless-ngx.version;
  };
}
