require 'yelp/responses/base'

module Yelp
  module Response
    module Model
      class Rating < Response::Base
        attr_reader :rating, :img_url
      end
    end
  end
end
