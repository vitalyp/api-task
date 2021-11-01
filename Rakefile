# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'test'

require './config/environment'

require 'sinatra/activerecord/rake'
Dir.glob('lib/tasks/*.rake').each { |r| load r }
