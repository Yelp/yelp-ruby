require 'yelp/models/base'
require 'yelp/models/deal'
require 'yelp/models/gift_certificate'
require 'yelp/models/location'
require 'yelp/models/review'

module Model
  class Business < Base
    attr_accessor :categories, :deals, :display_phone, :distance, :eat24_url, :gift_certificates, :id, :image_url,
                  :is_claimed, :is_closed, :location, :menu_provider, :menu_date_updated, :mobile_url, :name, :phone,
                  :rating, :reviews, :reservation_url, :review_count, :snippet_image_url, :snippet_text, :url

    def initialize(json)
      super(json)

      @deals             = parse(@deals, Deal)
      @gift_certificates = parse(@gift_certificates, GiftCertificate)
      @location          = parse(@location, Location)
      @reviews           = parse(@reviews, Review)
    end
  end
end
