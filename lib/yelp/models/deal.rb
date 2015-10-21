require 'yelp/models/base'
require 'yelp/models/deal_option'

module Model
  class Deal < Base
    attr_accessor :additional_restrictions, :currency_code, :image_url, :important_restriction, :is_popular,
                  :id, :options, :time_end, :time_start, :title, :url, :what_you_get
  end
end
