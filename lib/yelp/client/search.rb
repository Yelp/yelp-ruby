require 'json'

module Yelp
  class Client
    module Search
      PATH = '/v2/search'

      BOUNDING_BOX = [:sw_latitude, :sw_longitude, :ne_latitude, :ne_longitude]
      COORDINATES  = [:latitude, :longitude, :accuracy, :altitude, :altitude_accuracy]

      # Take a search_request and return the formatted/structured
      # response from the API
      def search(location, params = {}, locale = {})
        params.merge!(locale)
        params.merge!({location: location})

        DeepStruct.new(JSON.parse(search_request(params).body))
      end

      # Search by a bounding box: specify a south west lat/long and a ne lat/long
      # along with regular parameters to make a request to the search endpoint
      # More info at: http://www.yelp.com/developers/documentation/v2/search_api#searchGBB
      def search_by_bounding_box(sw_latitude, sw_longitude, ne_latitude, ne_longitude, params = {}, locale = {})
        options = { bounds: "#{sw_latitude},#{sw_longitude}|#{ne_latitude},#{ne_longitude}" }
        options.merge!(params)
        options.merge!(locale)

        DeepStruct.new(JSON.parse(search_request(options).body))
      end

      # Search by coordinates: give it a latitude and longitude along with
      # option accuracy, altitude, and altitude_accuracy to search an area.
      # More info at: http://www.yelp.com/developers/documentation/v2/search_api#searchGC
      def search_by_coordinates(coordinates, params = {}, locale = {})
        options = { ll: build_coordinates_string(coordinates) }
        options.merge!(params)
        options.merge!(locale)

        DeepStruct.new(JSON.parse(search_request(options).body))
      end

      # Build the coordinates string for the api. Takes the hash of coordinates, loops
      # over the keys in the specific order they're listed in the API docs, and builds
      # that resulting string
      def build_coordinates_string(coordinates)
        COORDINATES.collect do |param|
          coordinates[param]
        end.join(',')
      end

      # Make a request against the search endpoint from the API
      # and return the raw response
      def search_request(params)
        @connection.get PATH, params
      end
    end
  end
end
