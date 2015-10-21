require 'yelp/models/base'

module Model
  class DealOption < Base
    attr_accessor :formatted_original_price, :formatted_price, :is_quantity_limited, :original_price,
                  :price, :purchase_url, :remaining_count, :title
  end
end
