require 'spec_helper'
require 'yelp'

describe Yelp::Client::Business do
  let(:keys) { Hash[consumer_key: ENV['YELP_CONSUMER_KEY'],
                    consumer_secret: ENV['YELP_CONSUMER_SECRET'],
                    token: ENV['YELP_TOKEN'],
                    token_secret: ENV['YELP_TOKEN_SECRET']] }
  let(:business) { 'yelp-san-francisco' }

  before do
    @client = Yelp::Client.new(keys)
  end

  describe 'business' do
    it 'should make a successful request to the api for the business' do
      VCR.use_cassette('business') do
        @client.business_request(business).status.should eql 200
      end
    end

    it 'should construct a deep struct of the response' do
      VCR.use_cassette('business') do
        @client.business(business).class.should eql DeepStruct
      end
    end

    it 'should get business information for the business' do
      VCR.use_cassette('business') do
        @client.business(business).name.should eql 'Yelp'
      end
    end
  end
end
