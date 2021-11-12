# frozen_string_literal: true

require './config/environment'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'

raise 'Migrations are pending' if ActiveRecord::Base.connection.migration_context.needs_migration?

require './app'

run App
