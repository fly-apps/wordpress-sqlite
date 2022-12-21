FROM wordpress

# Copy in performance plugin, with sqlite configuration enabled,
# including an empty-slate sqlite database
COPY wp-content/ /usr/src/wordpress/wp-content/
COPY wp-config.php /usr/src/wordpress/wp-config.php

# 1. Ensure a configuration file exists (default one is fine)
# 2. Ensure Apache doesn't strip x-forwarded-* headers in Fly
RUN rm /etc/apache2/conf-enabled/remoteip.conf
