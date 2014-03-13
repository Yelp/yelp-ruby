require 'faraday'
require 'faraday_middleware'
require 'yelp/client/search'

module Yelp
  class Client
    include Yelp::Client::Search

    AUTH_KEYS = [:consumer_key, :consumer_secret, :token, :token_secret]
    API_HOST  = 'http://api.yelp.com'

    attr_reader *AUTH_KEYS, :connection

    def initialize(options = {})
      AUTH_KEYS.each do |key|
        instance_variable_set("@#{key}", options[key])
      end

      configure
    end

    def configure
      keys = { consumer_key: @consumer_key,
               consumer_secret: @consumer_secret,
               token: @token,
               token_secret: @token_secret }

      @connection = Faraday.new API_HOST do |conn|
        conn.request :oauth, keys
        conn.adapter :net_http
      end
    end
  end
end
