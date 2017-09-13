require 'json'
require 'erb'

require 'yelp/responses/review'

module Yelp
    module Endpoint
        class Reviews
            PATH= '/v3/businesses/'
            REVIEWS= '/reviews'
            
            def initialize(client)
                @client = client
            end
            
          # Make a request to the reviews endpoint on the API
          #
          # @param id [String] the business id
          # @param locale [Hash] a hash of supported locale-related parameters
          # @return [Response::Review] the parsed response object from the API
          #
          # @example Get reviews
          #   business = client.reviews('yelp-san-francisco')
          #   business.name # => 'Yelp'
          #   buinesss.url  # => 'http://www.yelp.com/biz/yelp-san-francisco'
          def reviews(id, locale = {})
            Response::Review.new(JSON.parse(review_request(id, locale).body))
          end

          private

          # Make a request to the reviews endpoint of the API
          # The endpoint requires a format of /v3/reviews/{business-id}
          # so the primary request parameter is concatenated. After getting
          # the response back it's checked to see if there are any API errors
          # and raises the relevant one if there is.
          #
          # @param id [String, Integer] the business id
          # @param locale [Hash] a hash of supported locale-related parameters
          # @return [Faraday::Response] the raw response back from the connection
          def review_request(id, locale = {})
            result = @client.connection.get PATH + ERB::Util.url_encode(id) + REVIEWS, locale
            Error.check_for_error(result)
            result
          end
        end
    end
end