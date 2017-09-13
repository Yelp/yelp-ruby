require 'yelp/responses/base'
require 'yelp/responses/models/review'

module Yelp
    module Response
        class Review < Base 
            attr_reader :reviews, :total
            
            def initialize(json)
                super(json)
                @reviews = parse(@reviews, Model::Review)
            end
        end
    end
end