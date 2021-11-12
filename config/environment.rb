# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'
ENV['APP_ENV']  ||= 'development'

require 'dotenv'
Dotenv.load(".env.#{ENV['RACK_ENV']}")

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])
