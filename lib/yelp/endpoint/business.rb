require 'erb'
require 'json'

require 'yelp/responses/business'

module Yelp
  module Endpoint
    class Business
      PATH = '/v3/business/'

      def initialize(client)
        @client = client
      end

      # Make a request to the business endpoint on the API
      #
      # @param id [String] the business id
      # @param locale [Hash] a hash of supported locale-related parameters
      # @return [Response::Business] the parsed response object from the API
      #
      # @example Get business
      #   business = client.business('yelp-san-francisco')
      #   business.name # => 'Yelp'
      #   buinesss.url  # => 'http://www.yelp.com/biz/yelp-san-francisco'
      def business(id, locale = {})
        Response::Business.new(JSON.parse(business_request(id, locale).body))
      end

      private

      # Make a request to the business endpoint of the API
      # The endpoint requires a format of /v2/business/{business-id}
      # so the primary request parameter is concatenated. After getting
      # the response back it's checked to see if there are any API errors
      # and raises the relevant one if there is.
      #
      # @param id [String, Integer] the business id
      # @param locale [Hash] a hash of supported locale-related parameters
      # @return [Faraday::Response] the raw response back from the connection
      def business_request(id, locale = {})
        result = @client.connection.get PATH + ERB::Util.url_encode(id), locale
        Error.check_for_error(result)
        result
      end
    end
  end
end
