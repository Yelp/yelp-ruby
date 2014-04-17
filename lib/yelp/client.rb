require 'faraday'
require 'faraday_middleware'

require 'yelp/burst_struct'
require 'yelp/error'
require 'yelp/endpoint/business'
require 'yelp/endpoint/search'

module Yelp
  class Client
    AUTH_KEYS = [:consumer_key, :consumer_secret, :token, :token_secret]
    API_HOST  = 'http://api.yelp.com'
    REQUEST_CLASSES = [ Yelp::Endpoint::Search,
                        Yelp::Endpoint::Business ]

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
      define_request_methods
    end

    # Checks that all the keys needed were given
    def check_api_keys
      AUTH_KEYS.each do |key|
        raise MissingAPIKeys if instance_variable_get("@#{key}").nil?
      end
    end

    private

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

    # This goes through each endpoint class and creates singletone methods
    # on the client that query those classes. We do this to avoid possible
    # namespace collisions in the future when adding new classes
    def define_request_methods
      REQUEST_CLASSES.each do |request_class|
        endpoint_instance = request_class.new(self)
        create_methods_from_instance(endpoint_instance)
      end
    end

    # Loop through all of the endpoint instances' public singleton methods to
    # add the method to client
    def create_methods_from_instance(instance)
      instance.public_methods(false).each do |method_name|
        add_method(instance, method_name)
      end
    end

    # Define the method on the client and send it to the endpoint instance
    # with the args passed in
    def add_method(instance, method_name)
      define_singleton_method(method_name) do |*args|
        instance.public_send(method_name, *args)
      end
    end
  end
end
