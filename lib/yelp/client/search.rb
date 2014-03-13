require 'json'

module Yelp
  class Client
    module Search
      PATH = '/v2/search'

      def search(location, params = {}, locale = {})
        params.merge!(locale)
        params.merge!({location: location})

        JSON.parse(search_request.body)
      end

      def search_request(params)
        @connection.get PATH, params
      end
    end
  end
end
