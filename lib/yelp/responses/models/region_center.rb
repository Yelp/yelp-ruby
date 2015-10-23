require 'yelp/responses/base'

module Yelp
  module Response
    module Model
      class RegionCenter < Response::Base
        attr_accessor :latitude, :longitude
      end
    end
  end
end
