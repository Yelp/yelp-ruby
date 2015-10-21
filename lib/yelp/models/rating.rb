require 'yelp/models/base'

module Model
  class Rating < Base
    attr_accessor :rating, :img_url
  end
end
