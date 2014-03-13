module Yelp
  class Client
    AUTH_KEYS = [:consumer_key, :consumer_secret, :token, :token_secret]

    attr_reader *AUTH_KEYS

    def initialize(options = {})
      AUTH_KEYS.each do |key|
        instance_variable_set("@#{key}", options[key])
      end
    end
  end
end
