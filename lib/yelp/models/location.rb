require 'yelp/models/base'
require 'yelp/models/coordinate'

module Model
  class Location < Base
    attr_accessor :address, :city, :coordinate, :country_code, :cross_streets, :display_address, :geo_accuracy,
                  :neighborhoods, :postal_code, :state_code
  end
end
