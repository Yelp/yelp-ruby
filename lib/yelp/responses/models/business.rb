require 'yelp/responses/base'
require 'yelp/responses/models/deal'
require 'yelp/responses/models/gift_certificate'
require 'yelp/responses/models/location'
require 'yelp/responses/models/review'

module Yelp
  module Response
    module Model
      class Business < Response::Base
        attr_reader :categories, :deals, :display_phone, :distance, :eat24_url, :gift_certificates, :id, :image_url,
                    :is_claimed, :is_closed, :location, :menu_provider, :menu_date_updated, :mobile_url, :name, :phone,
                    :rating, :rating_img_url, :rating_img_url_small, :rating_img_url_large, :reviews, :reservation_url,
                    :review_count, :snippet_image_url, :snippet_text, :url

        def initialize(json)
          super(json)

          @deals             = parse(@deals, Deal)
          @gift_certificates = parse(@gift_certificates, GiftCertificate)
          @location          = parse(@location, Location)
          @reviews           = parse(@reviews, Review)
        end
      end
    end
  end
end
