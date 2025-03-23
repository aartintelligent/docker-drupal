FROM aartintelligent/php:8.4-composer AS composer

USER root

COPY drupal /drupal

WORKDIR /drupal

RUN set -eux; \
    composer install \
        --prefer-dist \
        --no-autoloader \
        --no-interaction \
        --no-scripts \
        --no-progress \
        --no-dev; \
    composer dump-autoload \
        --optimize

FROM aartintelligent/php:8.4-nginx AS webapp

USER root

COPY system /

COPY --chown=rootless:rootless drupal /var/www

COPY --chown=rootless:rootless --from=composer /drupal/vendor /var/www/vendor

USER rootless
