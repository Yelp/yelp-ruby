module Yelp
  class Configuration
    AUTH_KEYS = [:consumer_key, :consumer_secret, :token, :token_secret]

    attr_accessor *AUTH_KEYS

    # Returns a hash of api keys and their values
    def auth_keys
      AUTH_KEYS.inject({}) do |keys_hash, key|
        keys_hash[key] = send(key)
        keys_hash
      end
    end

    def valid?
      AUTH_KEYS.none?{ |key| send(key).nil? || send(key).empty? }
    end
  end
end