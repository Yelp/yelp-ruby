require 'spec_helper'
require 'yelp'

describe Yelp::Client::Search do
  let(:keys) { Hash[consumer_key: ENV['YELP_CONSUMER_KEY'],
                    consumer_secret: ENV['YELP_CONSUMER_SECRET'],
                    token: ENV['YELP_TOKEN'],
                    token_secret: ENV['YELP_TOKEN_SECRET']] }
  let(:location) { 'San Francisco' }
  let(:params) { Hash[term: 'restaurants',
                      category_filter: 'discgolf'] }

  before do
    @client = Yelp::Client.new(keys)
  end

  describe 'search' do
    it 'should make a successful search against the api' do
      VCR.use_cassette('search') do
        @client.search_request({location: location}).status.should eql 200
      end
    end

    it 'should construct a deep struct of the response' do
      VCR.use_cassette('search') do
        @client.search(location).class.should eql DeepStruct
      end
    end

    it 'should search the yelp api and get results' do
      VCR.use_cassette('search') do
        @client.search(location).businesses.size.should be > 0
      end
    end

    it 'should search the yelp api using a bounding box and get results' do
      VCR.use_cassette('search_bounding_box') do
        @client.search_by_bounding_box(37.7577, -122.4376, 37.785381, -122.391681).businesses.size.should be > 0
      end
    end
  end
end
