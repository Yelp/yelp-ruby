require 'yelp/responses/base'
require 'yelp/responses/models/gift_certificate_option'

module Yelp
  module Response
    module Model
      class GiftCertificate < Response::Base
        attr_reader :currency_code, :id, :image_url, :options, :unused_balances, :url

        def initialize(json)
          super(json)

          @options = parse(@options, GiftCertificateOption)
        end
      end
    end
  end
end
