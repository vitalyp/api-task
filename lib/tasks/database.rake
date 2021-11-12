# frozen_string_literal: true

require 'faker'

namespace :database do
  desc 'Recreate database from the scratch'
  task reset: %w[db:drop db:create db:migrate]
end
