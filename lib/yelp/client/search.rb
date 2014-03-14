require 'json'

module Yelp
  class Client
    module Search
      PATH = '/v2/search'

      BOUNDING_BOX = [:sw_latitude, :sw_longitude, :ne_latitude, :ne_longitude]
      COORDINATES  = [:latitude, :longitude]

      # Take a search_request and return the formatted/structured
      # response from the API
      def search(location, params = {}, locale = {})
        params.merge!(locale)
        params.merge!({location: location})

        DeepStruct.new(JSON.parse(search_request(params).body))
      end

      # Make a request against the search endpoint from the API
      # and return the raw response
      def search_request(params)
        @connection.get PATH, params
      end

      def search_by_bounding_box(sw_latitude, sw_longitude, ne_latitude, ne_longitude, params = {}, locale = {})
        options = { bounds: "#{sw_latitude},#{sw_longitude}|#{ne_latitude},#{ne_longitude}" }
        options.merge!(params)
        options.merge!(locale)

        DeepStruct.new(JSON.parse(search_request(options).body))
      end
    end
  end
end
