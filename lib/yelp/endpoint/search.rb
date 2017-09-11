require 'json'

require 'yelp/responses/search'

module Yelp
  module Endpoint
    class Search
      PATH = '/v3/businesses/search'

      BOUNDING_BOX = [:sw_latitude, :sw_longitude, :ne_latitude, :ne_longitude]
      COORDINATES  = [:latitude, :longitude, :accuracy, :altitude, :altitude_accuracy]

      def initialize(client)
        @client = client
      end

      # Take a search_request and return the formatted/structured
      # response from the API
      #
      # @param location [String] a string location of the neighborhood,
      #   address, or city
      # @param params [Hash] a hash that corresponds to params on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#searchGP
      # @param locale [Hash] a hash that corresponds to locale on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#lParam
      # @return [Response::Search] a parsed object of the response. For a complete
      #   list of possible response values visit:
      #   http://www.yelp.com/developers/documentation/v2/search_api#rValue
      #
      # @example Search for business with params and locale
      #   params = { term: 'food',
      #              limit: 3,
      #              category: 'discgolf' }
      #
      #   locale = { lang: 'fr' }
      #
      #   response = client.search('San Francisco', params, locale)
      #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
      #   response.businesses[0].name # 'Yelp'
      #
      # @example Search with only location and params
      #   params = { term: 'food' }
      #
      #   response = client.search('San Francisco', params)
      def search(location, params = {}, locale = {})
        params.merge!(locale)
        params.merge!({location: location})

        Response::Search.new(JSON.parse(search_request(params).body))
      end

      # Search by a bounding box: specify a south west lat/long and a ne lat/long
      # along with regular parameters to make a request to the search endpoint
      # More info at: http://www.yelp.com/developers/documentation/v2/search_api#searchGBB
      #
      # @param bounding_box [Hash] a hash of SW latitude/longitude and NE latitude/longitude,
      #   all 4 keys are required to be set
      # @param params [Hash] a hash that corresponds to params on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#searchGP
      # @param locale [Hash] a hash that corresponds to locale on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#lParam
      # @return [Response::Search] a parsed object of the response. For a complete
      #   list of possible response values visit:
      #   http://www.yelp.com/developers/documentation/v2/search_api#rValue
      #
      # @example Search for business with params and locale
      #   bounding_box = { sw_latitude: 37.785855, sw_longitude: -122.405780,
      #                    ne_latitude: 37.780632, ne_longitude: -122.388442 }
      #
      #   params = { term: 'food',
      #              limit: 3,
      #              category: 'discgolf' }
      #
      #   locale = { lang: 'fr' }
      #
      #   response = client.search(bounding_box, params, locale)
      #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
      #   response.businesses[0].name # 'Yelp'
      #
      # @example Search with only location and params
      #   bounding_box = { sw_latitude: 37.785855, sw_longitude: -122.405780,
      #                    ne_latitude: 37.780632, ne_longitude: -122.388442 }
      #
      #   params = { term: 'food' }
      #
      #   response = client.search(bounding_box, params)
      def search_by_bounding_box(bounding_box, params = {}, locale = {})
        raise Error::BoundingBoxNotComplete if BOUNDING_BOX.any? { |corner|
          bounding_box[corner].nil? }

        options = { bounds: build_bounding_box(bounding_box) }
        options.merge!(params)
        options.merge!(locale)

        Response::Search.new(JSON.parse(search_request(options).body))
      end

      # Search by coordinates: give it a latitude and longitude along with
      # option accuracy, altitude, and altitude_accuracy to search an area.
      # More info at: http://www.yelp.com/developers/documentation/v2/search_api#searchGC
      #
      # @param coordinates [Hash] a hash of latitude, longitude, accuracy,
      #   altitude, and altitude accuracy. Only latitude and longitude are required
      # @param params [Hash] a hash that corresponds to params on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#searchGP
      # @param locale [Hash] a hash that corresponds to locale on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#lParam
      # @return [Response::Search] a parsed object of the response. For a complete
      #   list of possible response values visit:
      #   http://www.yelp.com/developers/documentation/v2/search_api#rValue
      #
      # @example Search for business with params and locale
      #   coordinates = { latitude: 37.786732,
      #                   longitude: -122.399978 }
      #
      #   params = { term: 'food',
      #              limit: 3,
      #              category: 'discgolf' }
      #
      #   locale = { lang: 'fr' }
      #
      #   response = client.search(coordinates, params, locale)
      #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
      #   response.businesses[0].name # 'Yelp'
      #
      # @example Search with only location and params
      #   coordinates = { latitude: 37.786732,
      #                   longitude: -122.399978 }
      #
      #   params = { term: 'food' }
      #
      #   response = client.search(coordinates, params)
      def search_by_coordinates(coordinates, params = {}, locale = {})
        raise Error::MissingLatLng if coordinates[:latitude].nil? ||
            coordinates[:longitude].nil?

        options = { ll: build_coordinates_string(coordinates) }
        options.merge!(params)
        options.merge!(locale)

        Response::Search.new(JSON.parse(search_request(options).body))
      end

      private

      # Build the bounding box for the API. Takes in a hash of the bounding box and
      # combines the coordinates into the properly formatted string
      def build_bounding_box(bounding_box)
        "#{bounding_box[:sw_latitude]},#{bounding_box[:sw_longitude]}|#{bounding_box[:ne_latitude]},#{bounding_box[:ne_longitude]}"
      end

      # Build the coordinates string for the api. Takes the hash of coordinates, loops
      # over the keys in the specific order they're listed in the API docs, and builds
      # that resulting string
      def build_coordinates_string(coordinates)
        COORDINATES.collect do |param|
          coordinates[param]
        end.join(',')
      end

      # Make a request against the search endpoint from the API and return the
      # raw response. After getting the response back it's checked to see if
      # there are any API errors and raises the relevant one if there is.
      #
      # @param params [Hash] a hash of parameters for the search request
      # @return [Faraday::Response] the raw response back from the connection
      def search_request(params)
        result = @client.connection.get PATH, params
        Error.check_for_error(result)
        result
      end
    end
  end
end
