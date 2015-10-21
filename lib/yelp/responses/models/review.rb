require 'yelp/responses/base'
require 'yelp/responses/models/rating'

module Yelp
  module Response
    module Model
      class Review < Base
        attr_accessor :excerpt, :id, :rating, :time_created, :user

        def initialize(json)
          super(json)

          @rating = parse(@rating, Rating)
        end
      end
    end
  end
end
