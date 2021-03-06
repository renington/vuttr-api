# VUTTR
Very Useful Tools to Remember

## Heroku Demo
https://vuttr-future.herokuapp.com/

### Get token
ROUTE: https://vuttr-future.herokuapp.com/api/v1/user_token
```
{ "auth": { "email": "test@test.com", "password": "123456789" }} 
```
#### More routes in blueprint documentation

## Getting Started
#### Prerequisites
- [Docker](https://www.docker.com/)
- [Git](https://git-scm.com/)

### Installing
```
$ git clone 'https://github.com/renington/vuttr-api.git'
$ cd vuttr-api
$ docker-compose up --build
$ docker-compose run --rm web rails db:create
$ docker-compose run --rm web rails db:migrate
$ docker-compose run --rm web rails db:seed
```

### Running app
```
$ docker-compose up
Now, it is available on: http://localhost:3000/
```

### Available routes
[Blueprint Documentation](https://github.com/renington/vuttr-api/blob/master/app/spec/apispec.md)

## Running tests
```
$ docker-compose run --rm app rspec
```

## Running blueprint (CLI)
```
$ docker-compose run web rspec spec -f ApiBlueprint
```

## Generating blueprint documentation
```
$ docker-compose run web rake generate_api_docs
```

## Built With

* [Docker](http://www.dropwizard.io/1.0.2/docs/) - Development environment
* [Ruby](https://www.ruby-lang.org/) - The language 
* [Bundler](https://bundler.io/) - Dependency Management
* [RSPEC](https://rspec.info/) - The Test tool 
* [PostgreSQL](https://www.postgresql.org/) - Database
* [knock - JWT](https://github.com/nsarno/knock) - Seamless JWT authentication for Rails API
* [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) - Factory Bot
* [rspec-api-blueprint-formatter](https://github.com/nambrot/rspec-api-blueprint-formatter) - Auto-generate API docs from your RSpec tests!
