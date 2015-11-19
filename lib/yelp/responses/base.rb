require 'set'

module Yelp
  module Response
    class Base
      SKIP = Set.new([
        'rating_image_url',
        'rating_image_small_url',
        'rating_image_large_url',
        'rating_img_url',
        'rating_img_url_small',
        'rating_img_url_large'
      ])

      def initialize(json)
        return if json.nil?

        json.each do |key, value|
          instance_variable_set("@#{key}", value) unless SKIP.include?(key)
        end
      end

      private

      def parse(json, klass)
        return json.collect { |j| klass.new(j) } if json.is_a?(Array)
        return klass.new(json) if json
        nil
      end
    end
  end
end
