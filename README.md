api-task
========
### Prerequisites
    Ruby - 2.7.3
    Bundler - 2+
    Postgres

### Setup
- git clone git@github.com:vitalyp/api-task.git
- bundle install
- RACK_ENV=test bundle exec rake db:create db:migrate
- RACK_ENV=development bundle exec rake db:create db:migrate database:reset

### Rake database tasks

    database:reset

       
### Checks
- bundle exec rspec spec
- bundle exec rubocop
- bundle exec brakeman

### docker-compose-postgres.yml
    docker-compose -f docker-compose-postgres.yml up
    ssh uusseerr@hhoosstt.labs.play-with-docker.com
    docker run -d -p 8080:80 nginx
   
> .
>
>
>
> todo .
>
>
>
> .
  