# frozen_string_literal: true

require 'faker'

namespace :database do
  desc 'Recreate database from the scratch'
  task reset: %w[db:drop db:create db:migrate]

  desc 'Fill db with data'
  task load: :environment do
    puts 'creating users..'
    puts 'creating posts..'
  end
end
