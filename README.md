# README

## Requirement
* Ruby version 2.5
* Ruby on Rails version 5.1.4

### Database initialization

```
bundle exec rails db:migrate
bundle exec rails db:seed
```

### Start the server

```
bundle exec rails s -b 0.0.0.0
```

open http://localhost:3000

### Use the Docker

How to launch this application with Docker.
Dockerfile already exists.

```
docker build -t temp .
docker run --rm -it -v (pwd):/myapp -p 80:3000 temp /bin/bash
```

And follow the instructions above to start the server.

open http://localhost
