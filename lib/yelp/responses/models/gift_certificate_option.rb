require 'yelp/responses/base'

module Yelp
  module Response
    module Model
      class GiftCertificateOption < Response::Base
        attr_accessor :formatted_price, :price
      end
    end
  end
end
