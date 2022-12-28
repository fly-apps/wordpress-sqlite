# Wordpress on SQLite on Fly

Wordpress can be run on SQLite! Read more here: https://make.wordpress.org/core/2022/12/20/help-us-test-the-sqlite-implementation/

This project extends the `wordpress` base image, adds in the [Performance Lab](https://wordpress.org/plugins/performance-lab/) plugin, and enables the SQLite option.

For now, enabling SQLite requires a MySQL database to copy some settings from. For this project, we've baked in a SQLite database located at `/var/www/html/wp-content/database/.ht.sqlite`.

## Running this on Fly

You can run this quickly on a Fly Machine:

```bash
# Create a Machine App to house our Machine VM
fly apps create --machines --name my-wp-app

# Make it publicly available on the internet
fly ips allocate-v4 --shared -a my-wp-app
fly ips allocate-v6 -a my-wp-app

# Start a Machine VM in the app
# This builds the app based on the Dockerfile
# in the current directory
fly m run . -p 443:80/tcp:tls -a my-wp-app
```

## Administering Wordpress

Since we chose to bake in a SQLite database, there are a few things to note:

1. Log into `/wp-admin` with username/password `admin`/`admin`
    - Feel free to change this as desired
2. The [`wp-config.php`](https://github.com/fly-apps/wordpress-sqlite/blob/main/wp-config.php#L42-L47) has a bit of extra code to make it work with ad-hoc `https://*.fly.dev` domains

> If anyone knows why Apache in the default Wordpress docker install seems to remove X-Forwarded headers, let us know! Removing `/etc/apache2/conf-enabled/remoteip.conf` didn't see to have any effect.
