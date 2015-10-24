require 'yelp/responses/base'
require 'yelp/responses/models/business'
require 'yelp/responses/models/region'

module Yelp
  module Response
    class Search < Base
      attr_reader :businesses, :region, :total

      def initialize(json)
        super(json)

        @businesses = parse(@businesses, Model::Business)
        @region     = parse(@region, Model::Region)
      end
    end
  end
end
