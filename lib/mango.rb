require 'rest_client'
require 'json'
require_relative 'mango/resources'

module Mango

  class Error < StandardError
    include Enumerable
    attr_accessor :errors

    def initialize message, errors={}
      super message
      @errors = errors
    end

    # Yield [error_code, message] pairs
    def each
      @errors.each { |e| yield *e.first }
    end
  end

  @api_base = 'https://api.getmango.com/v1'

  class << self
    attr_accessor :api_key, :api_base
  end

  def self.request(method, url, api_key=nil, params={}, headers={})
    method = method.to_sym

    url = @api_base + url

    unless api_key ||= @api_key
      raise Error.new('No API key provided')
    end

    payload = JSON.generate(params) if method == :post || method == :patch

    headers = {
      :content_type => 'application/json'
    }.merge(headers)

    options = {
      :headers => headers,
      :user => api_key,
      :method => method,
      :url => url,
      :payload => payload
    }

    begin
      response = execute_request(options)
      return {} if response.code == 204 and method == :delete
      JSON.parse(response.body, :symbolize_names => true)
    rescue RestClient::Exception => e
      handle_errors e
    end
  end

  private

  def self.execute_request(options)
    RestClient::Request.execute(options)
  end

  def self.handle_errors exception
    body = JSON.parse exception.http_body
    raise Error.new(exception.to_s, body['errors'])
  end

end
