require 'yelp/responses/base'

module Yelp
  module Response
    module Model
      class Review < Base
        attr_reader :excerpt, :id, :rating, :rating_image_url, :rating_image_small_url,
                    :rating_image_large_url, :time_created, :user
      end
    end
  end
end
