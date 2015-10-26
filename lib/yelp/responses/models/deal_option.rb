require 'yelp/responses/base'

module Yelp
  module Response
    module Model
      class DealOption < Response::Base
        attr_reader :formatted_original_price, :formatted_price, :is_quantity_limited, :original_price,
                    :price, :purchase_url, :remaining_count, :title
      end
    end
  end
end
