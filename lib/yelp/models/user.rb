require 'yelp/models/base'

module Model
  class User < Base
    attr_accessor :id, :image_url, :name
  end
end
