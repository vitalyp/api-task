# frozen_string_literal: true

require 'active_support/inflector'

module TinyApiClient
  # Wrapper around net/http Net::HTTPRequest
  class Request
    HTTP_REQUEST_CLASSES = %w(
      Get
      Head
      Post
      put
      patch
      delete
    ).freeze

    attr_reader :object

    def initialize(method, path, header, body)
      request_classname = method.to_s.capitalize
      raise ArgumentError.new("Method #{method} not supported") unless HTTP_REQUEST_CLASSES.include? request_classname

      @object = "Net::HTTP::#{request_classname}".constantize.new(path, header)
      @object.body = body ? serialize(body) : nil
    end

    private

    def serialize(body_obj)
      is_json = JSON.parse(body_obj) rescue nil
      is_json ? body_obj : body_obj.to_json
    end
  end
end

