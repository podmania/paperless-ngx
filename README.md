# paperless-ngx

Scan, index, and archive all of your physical documents.

Upstream: [paperless-ngx/paperless-ngx](https://github.com/paperless-ngx/paperless-ngx)  
Documentation: [docs.paperless-ngx.com](https://docs.paperless-ngx.com/)

## Ports

- `8000` — Web UI

## Volumes

- `/data` — Search index, SQLite DB, classification model
- `/media` — Stored documents and thumbnails
- `/consume` — Directory watched for new documents
- `/export`

## Environment Variables

### Redis

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_REDIS` | `redis://localhost:6379` | Redis URL for task broker |
| `PAPERLESS_REDIS_PREFIX` | _(none)_ | Prefix for Redis keys (for sharing Redis among instances) |

### Database

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_DBHOST` | _(unset = SQLite)_ | Database hostname |
| `PAPERLESS_DBENGINE` | `postgresql` | Engine: `postgresql` or `mariadb` |
| `PAPERLESS_DBPORT` | `5432` / `3306` | Database port |
| `PAPERLESS_DBNAME` | `paperless` | Database name |
| `PAPERLESS_DBUSER` | `paperless` | Database username |
| `PAPERLESS_DBPASS` | `paperless` | Database password |
| `PAPERLESS_DBSSLMODE` | `prefer` / `PREFERRED` | SSL mode for database connections |
| `PAPERLESS_DBSSLROOTCERT` | _(none)_ | Path to SSL root CA certificate |
| `PAPERLESS_DBSSLCERT` | _(none)_ | Path to client SSL certificate |
| `PAPERLESS_DBSSLKEY` | _(none)_ | Path to client SSL private key |
| `PAPERLESS_DB_TIMEOUT` | _(Django default)_ | Connection wait timeout |
| `PAPERLESS_DB_POOLSIZE` | _(disabled)_ | Max pooled connections (PostgreSQL only) |
| `PAPERLESS_DB_READ_CACHE_ENABLED` | `false` | Cache DB read queries into Redis |
| `PAPERLESS_READ_CACHE_TTL` | `3600` | Read cache TTL in seconds |
| `PAPERLESS_READ_CACHE_REDIS_URL` | _(uses main Redis)_ | Dedicated Redis URL for read cache |

### Tika

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_TIKA_ENABLED` | `false` | Enable Tika parser for Office documents and emails |
| `PAPERLESS_TIKA_ENDPOINT` | `http://localhost:9998` | Tika server URL |
| `PAPERLESS_TIKA_GOTENBERG_ENDPOINT` | `http://localhost:3000` | Gotenberg server URL |

### Paths

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_CONSUMPTION_DIR` | `../consume/` | Directory for documents to be consumed |
| `PAPERLESS_DATA_DIR` | `../data/` | Search index, SQLite DB, classification model storage |
| `PAPERLESS_EMPTY_TRASH_DIR` | _(files are deleted)_ | Directory where deleted originals are moved |
| `PAPERLESS_MEDIA_ROOT` | `../media/` | Storage for documents and thumbnails |
| `PAPERLESS_STATICDIR` | `../static/` | `STATIC_ROOT` for collectstatic |
| `PAPERLESS_FILENAME_FORMAT` | _(disabled)_ | Custom filename format for stored documents |
| `PAPERLESS_FILENAME_FORMAT_REMOVE_NONE` | `false` | Omit `none` placeholders from filename format |
| `PAPERLESS_LOGGING_DIR` | `PAPERLESS_DATA_DIR/log/` | Directory for log files |
| `PAPERLESS_NLTK_DIR` | `/usr/share/nltk_data` | NLTK data directory |
| `PAPERLESS_MODEL_FILE` | `PAPERLESS_DATA_DIR/classification_model.pickle` | Classification model storage path |

### Logging

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_LOGROTATE_MAX_SIZE` | 1 MiB | Max log file size before rotation (bytes) |
| `PAPERLESS_LOGROTATE_MAX_BACKUPS` | `20` | Number of rotated log files to keep |

### Hosting and Security

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_SECRET_KEY` | _(see settings.py)_ | Secret key for session tokens |
| `PAPERLESS_URL` | _(empty)_ | Base URL (no trailing slash); sets `ALLOWED_HOSTS`, CORS, CSRF |
| `PAPERLESS_CSRF_TRUSTED_ORIGINS` | _(empty)_ | Trusted origins for CSRF (comma-separated) |
| `PAPERLESS_ALLOWED_HOSTS` | `*` | Allowed hosts for HTTP host header validation |
| `PAPERLESS_CORS_ALLOWED_HOSTS` | `http://localhost:8000` | Allowed CORS hosts |
| `PAPERLESS_TRUSTED_PROXIES` | _(empty)_ | Trusted proxy IP addresses |
| `PAPERLESS_FORCE_SCRIPT_NAME` | _(none)_ | Subpath for hosting (e.g. `/paperless`) |
| `PAPERLESS_STATIC_URL` | `/static/` | URL path for static files |
| `PAPERLESS_AUTO_LOGIN_USERNAME` | _(none)_ | Auto-login as this user |
| `PAPERLESS_ADMIN_USER` | _(none)_ | Auto-create superuser at start |
| `PAPERLESS_ADMIN_MAIL` | `root@localhost` | Superuser email |
| `PAPERLESS_ADMIN_PASSWORD` | _(none)_ | Superuser password |
| `PAPERLESS_COOKIE_PREFIX` | `""` | Prefix for session cookies |
| `PAPERLESS_ENABLE_HTTP_REMOTE_USER` | `false` | Enable HTTP Remote-User SSO auth |
| `PAPERLESS_ENABLE_HTTP_REMOTE_USER_API` | `false` | Enable HTTP Remote-User auth for API |
| `PAPERLESS_HTTP_REMOTE_USER_HEADER_NAME` | `HTTP_REMOTE_USER` | Header name for remote user extraction |
| `PAPERLESS_LOGOUT_REDIRECT_URL` | _(none)_ | URL to redirect after logout |
| `PAPERLESS_USE_X_FORWARD_HOST` | `false` | Django `USE_X_FORWARDED_HOST` |
| `PAPERLESS_USE_X_FORWARD_PORT` | `false` | Django `USE_X_FORWARDED_PORT` |
| `PAPERLESS_PROXY_SSL_HEADER` | _(none)_ | Django `SECURE_PROXY_SSL_HEADER` (JSON list) |
| `PAPERLESS_EMAIL_CERTIFICATE_LOCATION` | _(none)_ | Additional SSL cert for mail provider validation |

### Authentication and SSO

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_ACCOUNT_ALLOW_SIGNUPS` | `false` | Allow new account signups |
| `PAPERLESS_ACCOUNT_DEFAULT_GROUPS` | _(none)_ | Groups for new signups (comma-separated) |
| `PAPERLESS_SOCIALACCOUNT_PROVIDERS` | _(none)_ | django-allauth social provider config (JSON) |
| `PAPERLESS_SOCIAL_AUTO_SIGNUP` | `false` | Auto-signup via third-party auth |
| `PAPERLESS_SOCIALACCOUNT_ALLOW_SIGNUPS` | `true` | Allow signups via third-party auth |
| `PAPERLESS_SOCIAL_ACCOUNT_SYNC_GROUPS` | `false` | Sync groups from third-party auth |
| `PAPERLESS_SOCIAL_ACCOUNT_DEFAULT_GROUPS` | _(none)_ | Default groups for social account signups |
| `PAPERLESS_ACCOUNT_DEFAULT_HTTP_PROTOCOL` | `https` | Protocol for generated URLs |
| `PAPERLESS_ACCOUNT_EMAIL_VERIFICATION` | `optional` | Email verification during signup |
| `PAPERLESS_ACCOUNT_EMAIL_UNKNOWN_ACCOUNTS` | `true` | django-allauth `EMAIL_UNKNOWN_ACCOUNTS` |
| `PAPERLESS_DISABLE_REGULAR_LOGIN` | `false` | Disable username/password login form |
| `PAPERLESS_REDIRECT_LOGIN_TO_SSO` | `false` | Auto-redirect to first SSO provider |
| `PAPERLESS_ACCOUNT_SESSION_REMEMBER` | `true` | Sessions expire on browser close if false |
| `PAPERLESS_SESSION_COOKIE_AGE` | `1209600` | Session cookie expiration (seconds) |

### OCR

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_OCR_LANGUAGE` | `eng` | OCR language (3-letter Tesseract code) |
| `PAPERLESS_OCR_MODE` | `skip` | OCR mode: `skip`, `redo`, or `force` |
| `PAPERLESS_OCR_SKIP_ARCHIVE_FILE` | `never` | When to skip archive creation: `never`, `with_text`, `always` |
| `PAPERLESS_OCR_CLEAN` | `clean` | unpaper mode: `clean`, `clean-final`, `none` |
| `PAPERLESS_OCR_DESKEW` | `true` | Correct document skew |
| `PAPERLESS_OCR_ROTATE_PAGES` | `true` | Auto-correct page rotation |
| `PAPERLESS_OCR_ROTATE_PAGES_THRESHOLD` | `12` | Rotation detection threshold |
| `PAPERLESS_OCR_OUTPUT_TYPE` | `pdfa` | PDF output type: `pdf`, `pdfa`, `pdfa-1`, `pdfa-2`, `pdfa-3` |
| `PAPERLESS_OCR_PAGES` | _(all pages)_ | Max pages to OCR per document |
| `PAPERLESS_OCR_IMAGE_DPI` | _(auto)_ | Fallback DPI for images |
| `PAPERLESS_OCR_MAX_IMAGE_PIXELS` | _(Pillow default)_ | Max image pixel count before warning/skip |
| `PAPERLESS_OCR_COLOR_CONVERSION_STRATEGY` | _(none)_ | Ghostscript color strategy for PDF/A |
| `PAPERLESS_OCR_USER_ARGS` | _(none)_ | Additional OCRmyPDF arguments (JSON) |

### Software Tweaks

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_TASK_WORKERS` | `1` | Number of parallel background tasks |
| `PAPERLESS_THREADS_PER_WORKER` | _(auto)_ | Threads per worker for OCR |
| `PAPERLESS_WORKER_TIMEOUT` | `1800` | Worker timeout in seconds |
| `PAPERLESS_TIME_ZONE` | `UTC` | Application time zone |
| `PAPERLESS_ENABLE_NLTK` | `true` | Enable advanced NLP for classification |
| `PAPERLESS_DATE_PARSER_LANGUAGES` | _(inferred from OCR_LANGUAGE)_ | Languages for date parsing |
| `PAPERLESS_EMAIL_TASK_CRON` | `*/10 * * * *` | Email fetch cron schedule |
| `PAPERLESS_TRAIN_TASK_CRON` | `5 */1 * * *` | Classifier training cron schedule |
| `PAPERLESS_INDEX_TASK_CRON` | `0 0 * * *` | Search index update cron schedule |
| `PAPERLESS_SANITY_TASK_CRON` | `30 0 * * sun` | Sanity checker cron schedule |
| `PAPERLESS_WORKFLOW_SCHEDULED_TASK_CRON` | `5 */1 * * *` | Scheduled workflow cron |
| `PAPERLESS_ENABLE_COMPRESSION` | `true` | Enable webserver response compression |
| `PAPERLESS_CONVERT_MEMORY_LIMIT` | `0` | ImageMagick memory limit (MB) |
| `PAPERLESS_CONVERT_TMPDIR` | _(none)_ | ImageMagick temp directory |
| `PAPERLESS_APPS` | _(none)_ | Additional Django apps (comma-separated) |
| `PAPERLESS_MAX_IMAGE_PIXELS` | _(none)_ | Max PIL image size |

### Document Consumer

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_CONSUMER_DISABLE` | _(enabled)_ | Disable directory-based consumer |
| `PAPERLESS_CONSUMER_DELETE_DUPLICATES` | `false` | Delete duplicate documents |
| `PAPERLESS_CONSUMER_RECURSIVE` | `false` | Watch subdirectories recursively |
| `PAPERLESS_CONSUMER_SUBDIRS_AS_TAGS` | `false` | Use subdirectory names as tags |
| `PAPERLESS_CONSUMER_IGNORE_PATTERNS` | `[".DS_Store", …]` | File/folder patterns to ignore (JSON array) |
| `PAPERLESS_CONSUMER_BARCODE_SCANNER` | `PYZBAR` | Barcode scanner engine: `PYZBAR` or `ZXING` |
| `PAPERLESS_PRE_CONSUME_SCRIPT` | _(none)_ | Script to run before consumption |
| `PAPERLESS_POST_CONSUME_SCRIPT` | _(none)_ | Script to run after consumption |
| `PAPERLESS_FILENAME_DATE_ORDER` | _(none)_ | Date order for filename parsing (e.g. `DMY`) |
| `PAPERLESS_NUMBER_OF_SUGGESTED_DATES` | `3` | Max suggested dates per document |
| `PAPERLESS_THUMBNAIL_FONT_NAME` | _(Liberation Serif)_ | Font for plain text thumbnails |
| `PAPERLESS_IGNORE_DATES` | _(empty)_ | Dates to ignore during parsing (comma-separated) |
| `PAPERLESS_DATE_ORDER` | `DMY` | Expected date format order in documents |
| `PAPERLESS_ENABLE_GPG_DECRYPTOR` | `false` | Enable GPG decryption for encrypted emails |

### Consumer Polling

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_CONSUMER_POLLING` | `0` | Polling interval in seconds (0 = use inotify) |
| `PAPERLESS_CONSUMER_POLLING_RETRY_COUNT` | `5` | Max retries before consuming |
| `PAPERLESS_CONSUMER_POLLING_DELAY` | `5` | Delay between polling checks (seconds) |
| `PAPERLESS_CONSUMER_INOTIFY_DELAY` | `0.5` | Wait time for additional inotify events (seconds) |

### Webhooks

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_WEBHOOKS_ALLOWED_SCHEMES` | `http,https` | Allowed webhook URL schemes |
| `PAPERLESS_WEBHOOKS_ALLOWED_PORTS` | _(all)_ | Allowed webhook ports |
| `PAPERLESS_WEBHOOKS_ALLOW_INTERNAL_REQUESTS` | `true` | Allow webhooks to internal URLs |

### Barcodes

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_CONSUMER_ENABLE_BARCODES` | `false` | Enable barcode-based page separation |
| `PAPERLESS_CONSUMER_BARCODE_TIFF_SUPPORT` | `false` | Scan TIFF files for barcodes |
| `PAPERLESS_CONSUMER_BARCODE_STRING` | `PATCHT` | Separator barcode string |
| `PAPERLESS_CONSUMER_BARCODE_RETAIN_SPLIT_PAGES` | `false` | Keep barcode split pages |
| `PAPERLESS_CONSUMER_ENABLE_ASN_BARCODE` | `false` | Detect ASN from barcodes |
| `PAPERLESS_CONSUMER_ASN_BARCODE_PREFIX` | `ASN` | ASN barcode prefix |
| `PAPERLESS_CONSUMER_BARCODE_UPSCALE` | `0.0` | Upscale factor for barcode detection |
| `PAPERLESS_CONSUMER_BARCODE_DPI` | `300` | DPI for barcode detection |
| `PAPERLESS_CONSUMER_BARCODE_MAX_PAGES` | `0` | Max pages to check (0 = all) |
| `PAPERLESS_CONSUMER_ENABLE_TAG_BARCODE` | `false` | Assign tags from barcodes |
| `PAPERLESS_CONSUMER_TAG_BARCODE_MAPPING` | `{"TAG:(.*)": "\\g<1>"}` | Regex-to-tag mapping (JSON) |

### Collate Double-Sided

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_CONSUMER_ENABLE_COLLATE_DOUBLE_SIDED` | `false` | Enable collation of two single-sided scans |
| `PAPERLESS_CONSUMER_COLLATE_DOUBLE_SIDED_SUBDIR_NAME` | `double-sided` | Subdirectory name for collation input |
| `PAPERLESS_CONSUMER_COLLATE_DOUBLE_SIDED_TIFF_SUPPORT` | `false` | TIFF support for collation |

### Trash

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_EMPTY_TRASH_DELAY` | `30` | Days before permanent deletion |
| `PAPERLESS_EMPTY_TRASH_TASK_CRON` | `0 1 * * *` | Cron schedule for emptying trash |

### OAuth (Gmail / Outlook)

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_OAUTH_CALLBACK_BASE_URL` | _(uses PAPERLESS_URL)_ | Base URL for OAuth callback |
| `PAPERLESS_GMAIL_OAUTH_CLIENT_ID` | _(none)_ | Gmail OAuth client ID |
| `PAPERLESS_GMAIL_OAUTH_CLIENT_SECRET` | _(none)_ | Gmail OAuth client secret |
| `PAPERLESS_OUTLOOK_OAUTH_CLIENT_ID` | _(none)_ | Outlook OAuth client ID |
| `PAPERLESS_OUTLOOK_OAUTH_CLIENT_SECRET` | _(none)_ | Outlook OAuth client secret |

### Email Parsing

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_EMAIL_PARSE_DEFAULT_LAYOUT` | _(none)_ | Default layout: `1`=Text+HTML, `2`=HTML+Text, `3`=HTML only, `4`=Text only |
| `PAPERLESS_EMAIL_GNUPG_HOME` | _(none)_ | GNUPG_HOME path for GPG decryptor |

### Audit Trail

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_AUDIT_LOG_ENABLED` | `true` | Enable audit trail for documents, types, correspondents, tags |

### Email Sending (SMTP)

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_EMAIL_HOST` | `localhost` | SMTP server hostname |
| `PAPERLESS_EMAIL_PORT` | `25` | SMTP server port |
| `PAPERLESS_EMAIL_HOST_USER` | _(empty)_ | SMTP username |
| `PAPERLESS_EMAIL_FROM` | _(same as EMAIL_HOST_USER)_ | From address for emails |
| `PAPERLESS_EMAIL_HOST_PASSWORD` | _(empty)_ | SMTP password |
| `PAPERLESS_EMAIL_USE_TLS` | `false` | Use TLS for SMTP |
| `PAPERLESS_EMAIL_USE_SSL` | `false` | Use SSL for SMTP |

### Frontend

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_APP_TITLE` | `Paperless-ngx` | Override default app name |
| `PAPERLESS_APP_LOGO` | _(none)_ | Path to custom logo in `/media/logo` |

### Binaries

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_CONVERT_BINARY` | `convert` | Path to ImageMagick convert binary |
| `PAPERLESS_GS_BINARY` | `gs` | Path to Ghostscript binary |

### Docker-Specific

| Variable | Default | Description |
| --- | --- | --- |
| `PAPERLESS_WEBSERVER_WORKERS` | `1` | Number of webserver worker processes |
| `PAPERLESS_BIND_ADDR` | `::` | IP address webserver listens on |
| `PAPERLESS_PORT` | `8000` | Port webserver listens on |
| `USERMAP_UID` | `1000` | UID of paperless user in container |
| `USERMAP_GID` | `1000` | GID of paperless group in container |
| `PAPERLESS_OCR_LANGUAGES` | _(none)_ | Additional OCR languages to install (space-separated) |
| `PAPERLESS_ENABLE_FLOWER` | _(disabled)_ | Enable Celery Flower monitoring |

<a href="https://www.buymeacoffee.com/bhoehn" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
