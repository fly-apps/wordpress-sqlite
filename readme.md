# Wordpress on SQLite on Fly

Based on https://make.wordpress.org/core/2022/12/20/help-us-test-the-sqlite-implementation/

This extends the `wordpress` base image, adds in the Performance plugin, and enables the SQLite option.

Since enabling SQLite right now requires a MySQL database to copy some settings from, we've instead baked in a default SQLite database in `wp-content/database/.ht.sqlite`.

## Running this on Fly

You can run this quickly on a Fly Machine:

```bash
fly apps create --machines --name my-wp-app
fly ips allocate-v4 --shared -a my-wp-app
fly ips allocate-v6 -a my-wp-app

# Build the app based on the Dockerfile
# in the current directory
fly m run . -p 443:8080/tcp:tls -a my-wp-app
```

