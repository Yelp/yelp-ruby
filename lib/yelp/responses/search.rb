require 'yelp/responses/base'
require 'yelp/responses/models/business'

module Yelp
  module Response
    class Search < Base
      def initialize(json)
        super(json)

        @businesses = parse(@businesses, Model::Business)
      end
    end
  end
end
