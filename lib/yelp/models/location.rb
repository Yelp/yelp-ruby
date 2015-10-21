require 'yelp/models/base'
require 'yelp/models/coordinate'

module Model
  class Location < Base
    attr_accessor :address, :city, :coordinate, :country_code, :cross_streets, :display_address, :geo_accuracy,
                  :neighborhoods, :postal_code, :state_code

    def initialize(json)
      super(json)

      @coordinate = parse(@coordinate, Coordinate)
    end
  end
end
