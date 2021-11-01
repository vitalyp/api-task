# frozen_string_literal: true

class UsersController < ApplicationController
  get '/users' do
    title 'user index'

    erb :users
  end
end
