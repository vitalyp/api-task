# frozen_string_literal: true

ruby '2.7.3'

source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib', require: false
gem 'puma'
gem 'rake'
gem 'require_all'
gem 'sinatra-activerecord'
gem 'pg'
gem 'dotenv'
gem 'conventional-changelog'

group :development do
  gem 'brakeman', require: false
  gem 'byebug'
  gem 'pry'
  gem 'rubocop', '~> 1.22', require: false
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec'
end

group :development, :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'rack-test'
  gem 'rspec'
end
