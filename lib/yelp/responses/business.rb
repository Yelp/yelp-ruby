require 'yelp/responses/base'
require 'yelp/responses/models/business'

module Yelp
  module Response
    class Business < Base
      attr_reader :business

      def initialize(json)
        @business = parse(json, Model::Business)
      end
    end
  end
end
