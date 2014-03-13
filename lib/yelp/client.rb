require 'oauth'
require 'yelp/client/search'

module Yelp
  class Client
    include Yelp::Client::Search

    AUTH_KEYS = [:consumer_key, :consumer_secret, :token, :token_secret]
    API_HOST  = 'http://api.yelp.com'

    attr_reader *AUTH_KEYS, :access_token

    def initialize(options = {})
      AUTH_KEYS.each do |key|
        instance_variable_set("@#{key}", options[key])
      end
    end

    def authorize
      consumer      ||= OAuth::Consumer.new(@consumer_key, @consumer_secret, site: API_HOST)
      @access_token ||= OAuth::AccessToken.new(consumer, @token, @token_secret)
    end
  end
end
