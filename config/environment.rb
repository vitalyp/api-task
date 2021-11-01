# frozen_string_literal: true

require 'dotenv'
Dotenv.load('.env.' + ENV['RACK_ENV'])

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])


