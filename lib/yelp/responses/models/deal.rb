require 'yelp/responses/base'
require 'yelp/responses/models/deal_option'

module Yelp
  module Response
    module Model
      class Deal < Response::Base
        attr_reader :additional_restrictions, :currency_code, :image_url, :important_restriction, :is_popular,
                    :id, :options, :time_end, :time_start, :title, :url, :what_you_get

        def initialize(json)
          super(json)

          @options = parse(@options, DealOption)
        end
      end
    end
  end
end

