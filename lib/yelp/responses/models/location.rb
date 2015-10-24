require 'yelp/responses/base'
require 'yelp/responses/models/coordinate'

module Yelp
  module Response
    module Model
      class Location < Response::Base
        attr_reader :address, :city, :coordinate, :country_code, :cross_streets, :display_address, :geo_accuracy,
                    :neighborhoods, :postal_code, :state_code

        def initialize(json)
          super(json)

          @coordinate = parse(@coordinate, Coordinate)
        end
      end
    end
  end
end
