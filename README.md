# README

## Requirement
* Ruby version 2.5
* Ruby on Rails version 5.1.4

## Development

### Database initialization

```sh
bin/rails db:migrate
bin/rails db:seed
```

### Start the server

```sh
bin/rails s -b 0.0.0.0
```

open http://localhost:3000

### Use the Docker

How to launch this application with Docker.
Dockerfile already exists.

```sh
docker build -t temp .
docker run --rm -it -v (pwd):/myapp -p 80:3000 temp /bin/bash
```

And follow the instructions above to start the server.

open http://localhost

## Deployment

Precompile assets to create asset files in the `public/assets`.

```sh
RAILS_ENV=production bin/rails assets:precompile
```

Migrate the production DB.

```sh
RAILS_ENV=production bin/rails db:migrate
```

Set values:

Create the secret.

```
bin/rails secret
```

Set the value to the `secret_key_base` in the `config/secrets.yml` or set the value in the environment variable `SECRET_KEY_BASE`

Set `config.public_file_server.enabled` as true in the `config/environments/production.rb` or set any value in the environment variable `RAILS_SERVE_STATIC_FILES`

And start the server. For example:

```sh
RAILS_ENV=production SECRET_KEY_BASE=7403e99b675a525b58da3c683caa230815679427c49a2e6f03a0461529e28deb1e7164bb219d6b8091476567f9c26faf55746adca7c4e3b0d780cf1312ee13e3 RAILS_SERVE_STATIC_FILES=true bin/rails s -b 0.0.0.0
```
