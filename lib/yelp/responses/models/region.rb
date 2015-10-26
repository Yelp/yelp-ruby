require 'yelp/responses/base'
require 'yelp/responses/models/region_center'
require 'yelp/responses/models/region_span'

module Yelp
  module Response
    module Model
      class Region < Response::Base
        attr_reader :center, :span

        def initialize(json)
          super(json)

          @center = parse(@center, RegionCenter)
          @span   = parse(@span, RegionSpan)
        end
      end
    end
  end
end
