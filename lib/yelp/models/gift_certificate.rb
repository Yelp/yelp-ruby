require 'yelp/models/base'
require 'yelp/models/gift_certificate_option'

module Model
  class GiftCertificate < Base
    attr_accessor :currency_code, :id, :image_url, :options, :unused_balances, :url

    def initialize(json)
      super(json)

      @options = parse(@options, GiftCertificateOption)
    end
  end
end
