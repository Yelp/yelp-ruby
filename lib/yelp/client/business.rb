require 'json'

module Yelp
  class Client
    module Business
      PATH = '/v2/business/'

      # Return a formatted/structured response from a request
      # to the business endpoint at the API
      def business(id)
        DeepStruct.new(JSON.parse(business_request(id).body))
      end

      # Make a request to the business endpoint of the API
      # The endpoint requires a format of /v2/business/{business-id}
      # so the primary request parameter is concatenated
      def business_request(id)
        @connection.get PATH + id
      end
    end
  end
end
