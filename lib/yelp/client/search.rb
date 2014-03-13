require 'json'

module Yelp
  class Client
    module Search
      PATH = '/v2/search'

      def search(location, params = {}, locale = {})
        params.merge(locale)
        params.merge({location: location})

        response = JSON.parse(get(PATH, params).body)
      end
    end
  end
end
