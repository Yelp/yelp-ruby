require 'faraday'
require 'faraday_middleware'

require 'yelp/burst_struct'
require 'yelp/configuration'
require 'yelp/error'
require 'yelp/endpoint/business'
require 'yelp/endpoint/phone_search'
require 'yelp/endpoint/search'

module Yelp
  class Client
    API_HOST  = 'http://api.yelp.com'
    REQUEST_CLASSES = [ Yelp::Endpoint::Search,
                        Yelp::Endpoint::Business,
                        Yelp::Endpoint::PhoneSearch]

    attr_reader :configuration

    # Creates an instance of the Yelp client
    # @param options [Hash, nil] a hash of the consumer key, consumer
    #   secret, token, and token secret
    # @return [Client] a new client initialized with the keys
    def initialize(options = nil)
      @configuration = nil
      define_request_methods

      unless options.nil?
        @configuration = Configuration.new(options)
        check_api_keys
      end
    end

    # Configure the API client
    # @yield [Configuration] a configuration object
    # @raise [MissingAPIKeys] if the configuration is invalid
    # @example Simple configuration
    #   Yelp.client.configure do |config|
    #     config.consumer_key = 'abc'
    #     config.consumer_secret = 'def'
    #     config.token = 'ghi'
    #     config.token_secret = 'jkl'
    #   end
    def configure
      raise Error::AlreadyConfigured unless @configuration.nil?

      @configuration = Configuration.new
      yield(@configuration)
      check_api_keys
    end

    # Checks that all the keys needed were given
    def check_api_keys
      if configuration.nil? || !configuration.valid?
        @configuration = nil
        raise Error::MissingAPIKeys
      else
        # Freeze the configuration so it cannot be modified once the gem is
        # configured.  This prevents the configuration changing while the gem
        # is operating, which would necessitate invalidating various caches.
        @configuration.freeze
      end
    end

    # API connection
    def connection
      return @connection if instance_variable_defined?(:@connection)

      check_api_keys
      @connection = Faraday.new(API_HOST) do |conn|
        # Use the Faraday OAuth middleware for OAuth 1.0 requests
        conn.request :oauth, @configuration.auth_keys

        # Using default http library, had to specify to get working
        conn.adapter :net_http
      end
    end

    private

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
