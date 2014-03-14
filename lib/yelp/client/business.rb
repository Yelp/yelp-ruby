require 'json'
require 'pry'

module Yelp
  class Client
    module Business
      PATH = '/v2/business/'

      def business(id)
        DeepStruct.new(JSON.parse(business_request(id).body))
      end

      def business_request(id)
        @connection.get PATH + id
      end
    end
  end
end
