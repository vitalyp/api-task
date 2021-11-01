# frozen_string_literal: true

require './config/environment'

raise 'Migrations are pending' if ActiveRecord::Base.connection.migration_context.needs_migration?

require 'sinatra/activerecord'

require_all 'app'

map('/')      { run ApplicationController }
map('/posts') { run PostsController }
map('/users') { run UsersController }

run ApplicationController
