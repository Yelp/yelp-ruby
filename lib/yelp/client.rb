require 'faraday'
require 'faraday_middleware'

require 'yelp/deep_struct'
require 'yelp/error'
require 'yelp/client/business'
require 'yelp/client/search'

module Yelp
  class Client
    include Yelp::Client::Business
    include Yelp::Client::Search

    AUTH_KEYS = [:consumer_key, :consumer_secret, :token, :token_secret]
    API_HOST  = 'http://api.yelp.com'

    attr_reader *AUTH_KEYS, :connection

    # Creates an instance of the Yelp client
    # Takes a hash then creates instance variables for each key, value pair passed
    def initialize(options = {})
      AUTH_KEYS.each do |key|
        instance_variable_set("@#{key}", options[key])
      end

      configure
    end

    # Configure Faraday for the API connection
    def configure
      keys = { consumer_key: @consumer_key,
               consumer_secret: @consumer_secret,
               token: @token,
               token_secret: @token_secret }

      @connection = Faraday.new API_HOST do |conn|
        # Use the Faraday OAuth middleware for OAuth 1.0 requests
        conn.request :oauth, keys

        # Using default http library, had to specify to get working
        conn.adapter :net_http
      end
    end

    def check_api_keys
      AUTH_KEYS.each do |key|
        raise MissingAPIKeys, "You're missing an API key" if instance_variable_get("@#{key}").nil?
      end
    end
  end
end
