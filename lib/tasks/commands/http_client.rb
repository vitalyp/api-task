# frozen_string_literal: true

require 'net/http'
require 'pry'

=begin IRB require snippet:
  require 'require_all';require_all './lib/tasks/commands';require 'dotenv';Dotenv.load(".env.local");
=end

module ApiTask
  # HttpClient performs fast HTTP requests through persisted connection with destination server.
  # Using:
  #   client = HttpClient.new('127.0.0.1:3000')    # => params String: hostname or ip address (:port)
  #   client.check_connection!                     # => throw error unless HTTP_OK
  #   client.http_post('/user', { login: 'bill' }) # => params String, Hash/JSON: pathname, request body object
  #   client.http_get('/users/1')
  class HttpClient
    DEFAULT_HEADERS = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }.freeze

    def initialize(server_addr = nil)
      @server_uri = URI.parse(server_addr || ENV['API_SERVER_ENDPOINT'])
      @http_client = Net::HTTP.new(server_uri.host, server_uri.port)
    end

    def check_connection!
      response = http_head('/')
      raise StandardError, "HTTPError: #{response.inspect}" unless response.kind_of? Net::HTTPSuccess
    end

    def http_get(path)
      perform_request :get, path
    end

    def http_head(path)
      perform_request :head, path
    end

    def http_post(path, body)
      perform_request :post, path, body
    end

    def http_put(path, body)
      perform_request :put, path, body
    end

    def http_patch(path, body)
      perform_request :patch, path, body
    end

    def http_delete(path)
      perform_request :delete, path
    end

    # Persisted connection block
    def start
      begin
        http_client.start
        yield(self)
      ensure
        http_client.finish
      end
    end

    attr_reader :server_uri, :http_client

    private

    def perform_request(method, path, body = nil)
      req_object = Request.new(method, path, DEFAULT_HEADERS, body).object
      http_client.request(req_object)
    end
  end
end