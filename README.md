# Docker drupal

### Composer usage

```shell
docker run -it --rm \
  --name composer \
  -v $(pwd)/drupal:/var/www \
  -w /var/www \
  aartintelligent/php:8.4-composer install
```

```shell
docker run -it --rm \
  --name composer \
  -v $(pwd)/drupal:/var/www \
  -w /var/www \
  aartintelligent/php:8.4-composer update \
  "drupal/*" --with-all-dependencies
```



### Usage Docker

```shell
docker build . -t aartintelligent/drupal:latest
```

```shell
docker push aartintelligent/drupal:latest
```

### Usage Docker Compose

```shell
docker compose build
```

```shell
docker compose up -d
```

```shell
docker compose down -v
```

### Compose

```yaml
services:

  database:
    image: postgres:17
    user: root
    environment:
      - POSTGRES_DB=drupal
      - POSTGRES_USER=${POSTGRES_USER:-drupal}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-password}
      - PGDATA=/var/lib/postgresql/data/pgdata
    volumes:
      - database-volume:/var/lib/postgresql/data
      # - /opt/postgres/data:/var/lib/postgresql/data
    ports:
      - '5432:5432'

  website:
    build:
      context: .
      target: webapp
    #    environment:
    #      PHP_OPCACHE__ENABLE: 0
    #      PHP_OPCACHE__ENABLE_CLI: 0
    #      PHP_XDEBUG__MODE: debug
    volumes:
      - ./drupal:/var/www:rw,delegated
    ports:
      - '8080:8080'

volumes:
  database-volume:
```