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
    # @param options [Hash] a hash of the consumer key, consumer secret, token, and token secret
    # @return [Client] a new client initialized with the keys
    def initialize(options = {})
      AUTH_KEYS.each do |key|
        instance_variable_set("@#{key}", options[key])
      end

      check_api_keys
      configure_connection
    end

    # Configure Faraday for the API connection
    def configure_faraday
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
    alias_method :configure_connection, :configure_faraday

    # Checks that all the keys needed were given
    def check_api_keys
      AUTH_KEYS.each do |key|
        raise MissingAPIKeys, "You're missing an API key" if instance_variable_get("@#{key}").nil?
      end
    end
  end
end
