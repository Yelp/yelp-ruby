require 'yelp/models/base'
require 'yelp/models/rating'

module Model
  class Review < Base
    attr_accessor :excerpt, :id, :rating, :time_created, :user
  end
end
