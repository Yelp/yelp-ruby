require 'yelp/responses/base'

module Yelp
  module Response
    module Model
      class Coordinate < Response::Base
        attr_reader :latitude, :longitude
      end
    end
  end
end
