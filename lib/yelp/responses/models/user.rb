require 'yelp/responses/base'

module Yelp
  module Response
    module Model
      class User < Response::Base
        attr_reader :id, :image_url, :name
      end
    end
  end
end
