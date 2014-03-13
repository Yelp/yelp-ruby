module Yelp
  class Client
    module Search
      PATH = '/v2/search'

      def search(location, params = {}, locale = {})
        path = build_request(location, params, locale)
      end

      def build_request(location, params = {}, locale = {})
        path = PATH.dup
        path << '?'
        path << "location=#{location}"

        [params, locale].each do |hash|
          hash.each do |key,value|
            path << '&'
            path << "#{key}=#{value}"
          end
        end

        path
      end

      private
      # This is for Rspec only, this makes it easy to make sure that
      # the search module is getting the access token from Client
      def search_access_token
        @access_token
      end
    end
  end
end
