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
  let(:client) { Yelp::Client.new(keys) }

  describe 'search' do
    it 'should construct a deep struct of the response' do
      VCR.use_cassette('search') do
        client.search(location).class.should eql DeepStruct
      end
    end

    it 'should search the yelp api and get results' do
      VCR.use_cassette('search') do
        client.search(location).businesses.size.should be > 0
      end
    end

    it 'should search the yelp api using a bounding box and get results' do
      VCR.use_cassette('search_bounding_box') do
        bounding_box = {sw_latitude: 37.7577, sw_longitude: -122.4376, ne_latitude: 37.785381, ne_longitude: -122.391681}
        client.search_by_bounding_box(bounding_box).businesses.size.should be > 0
      end
    end

    it 'should search the yelp api using coordinates and get results' do
      VCR.use_cassette('coordinates') do
        client.search_by_coordinates({latitude: 37.7577, longitude: -122.4376}).businesses.size.should be > 0
      end
    end
  end

  describe 'errors' do
    it 'should throw an error if searching by coordinates and missing latitude or longitude' do
      lambda {
        client.search_by_coordinates({}, params)
      }.should raise_error
    end
  end

  it 'should throw an error if searching by bounding box and missing any of the box params' do
    lambda {
      client.search_by_bounding_box({}, params)
    }.should raise_error
  end
end
