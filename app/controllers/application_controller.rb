# frozen_string_literal: true

class ApplicationController < Sinatra::Base
  get '/' do
    response = { application: 'api-task', version: 0 }
    respond_with response, status: :ok

    halt(404, { message:'Book Not Found'}.to_json) unless book
  end

  not_found do
    respond_with({ message: 'Not Found', status: :not_found })
  end
end
