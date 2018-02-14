require 'yelp/responses/base'
require 'yelp/responses/models/review'

module Yelp
  module Response
    class Review < Base
      attr_reader :reviews

      def initialize(json)
        @reviews = parse(json, Model::Review)
      end
    end
  end
end
