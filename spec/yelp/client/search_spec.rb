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
      @client.search_request({location: location}).status.should eql 200
    end

    it 'should construct a deep struct of the response' do
      @client.search(location).class.should eql DeepStruct
    end

    it 'should search the yelp api and get results' do
      response.businesses.size.should be > 0
    end
  end
end
