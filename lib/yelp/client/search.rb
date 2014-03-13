require 'json'

module Yelp
  class Client
    module Search
      PATH = '/v2/search'

      def search(location, params = {}, locale = {}, full_response = false)
        params.merge!(locale)
        params.merge!({location: location})

        unless full_response
          return JSON.parse(get(PATH, params).body)
        else
          return get(PATH, params)
        end
      end
    end
  end
end
