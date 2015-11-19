require 'yelp/responses/base'

module Yelp
  module Response
    module Model
      class Rating
        attr_reader :rating

        def initialize(json)
          @rating = json['rating']

          # The Yelp API has two different names for the rating images depending on the object
          # it returns from. The rating model accomdates both those naming types and
          # standardizes it for the user
          @image  = { regular: json['rating_image_url']       || json['rating_img_url'],
                      small:   json['rating_image_small_url'] || json['rating_img_url_small'],
                      large:   json['rating_image_large_url'] || json['rating_img_url_large'] }
        end

        def image_url(size = :regular)
          @image[size] if @image[size]
        end

        def image_small_url
          image_url(:small)
        end

        def image_large_url
          image_url(:large)
        end

        # The naming from the response is consistent (img vs image, url_small vs small_url),
        # the aliases try to "standardize" them for the end user
        alias_method :img_url, :image_url
        alias_method :img_small_url, :image_small_url
        alias_method :img_large_url, :image_large_url
        alias_method :img_url_small, :image_small_url
        alias_method :img_url_large, :image_large_url
      end
    end
  end
end
