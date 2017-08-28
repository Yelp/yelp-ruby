require 'json'

require 'yelp/responses/phone_search'

module Yelp
  module Endpoint
    class PhoneSearch
      PATH = '/v3/phone_search/'

      def initialize(client)
        @client = client
      end

      # Make a request to the business endpoint on the API
      #
      # @param phone_number [String] the phone number
      # @return [Response::PhoneSearch] a parsed object of the response. For a complete
      #   sample response visit:
      #   http://www.yelp.com/developers/documentation/v2/phone_search#sampleResponse
      #
      # @example Search for business with params and locale
      #   options = { code: 'US',
      #              category: 'localflavor' }
      #
      #   response = client.phone_search('+14159083801', options)
      #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
      #   response.businesses[0].name # 'Yelp'
      #
      def phone_search(phone, options={})
        params = {phone: phone}
        params.merge!(options)

        Response::PhoneSearch.new(JSON.parse(phone_search_request(params).body))
      end

      private

      # Make a request to the business endpoint of the API
      # The endpoint requires a format of /v2/business/{business-id}
      # so the primary request parameter is concatenated. After getting
      # the response back it's checked to see if there are any API errors
      # and raises the relevant one if there is.
      #
      # @param params [Hash] a hash of options for phone search
      # @return [Faraday::Response] the raw response back from the connection
      def phone_search_request(params)
        result = @client.connection.get PATH, params
        Error.check_for_error(result)
        result
      end
    end
  end
end
