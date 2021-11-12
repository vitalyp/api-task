# frozen_string_literal: true

ruby '2.7.3'

source 'https://rubygems.org'

gem 'dotenv'
gem 'pg'
gem 'with_advisory_lock'
gem 'puma'
gem 'rake'
gem 'require_all'
gem 'shotgun'
gem 'sinatra'
gem 'sinatra-activerecord'
gem 'sinatra-contrib', require: false

group :development do
  gem 'brakeman', require: false
  gem 'rubocop', '~> 1.22', require: false
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec'
end

group :development, :test do
  gem 'byebug'
  gem 'pry'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rack-test'
  gem 'rspec'
end
