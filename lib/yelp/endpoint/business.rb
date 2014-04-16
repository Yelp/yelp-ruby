require 'json'

module Yelp
  module Endpoint
    class Business
      PATH = '/v2/business/'

      def initialize(client)
        @client = client
      end

      # Make a request to the business endpoint on the API
      #
      # @param id [String] the business id
      # @return [BurstStruct] the parsed response object from the API
      #
      # @example Get business
      #   business = client.business('yelp-san-francisco')
      #   business.name # => 'Yelp'
      #   buinesss.url  # => 'http://www.yelp.com/biz/yelp-san-francisco'
      def business(id)
        BurstStruct::Burst.new(JSON.parse(business_request(id).body))
      end

      private

      # Make a request to the business endpoint of the API
      # The endpoint requires a format of /v2/business/{business-id}
      # so the primary request parameter is concatenated
      #
      # @param id [String, Integer] the business id
      # @return [Faraday::Response] the raw response back from the connection
      def business_request(id)
        @client.connection.get PATH + id
      end
    end
  end
end
