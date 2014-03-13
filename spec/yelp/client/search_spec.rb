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

  describe 'inheritance' do
    it 'should get @connection from search' do
      @client.send(:search_connection).should eql @client.connection
    end
  end

  describe 'search' do
    it 'should build the requests path correctly' do
      path = @client.build_request(location, params)
      path.should include "?location=#{location}"
      path.should include "&term=#{params[:term]}"
      path.should include "&category_filter=#{params[:category_filter]}"
    end

    it 'should not overwrite the constant' do
      path = @client.build_request(location, params)
      Yelp::Client::Search::PATH.should eql '/v2/search'
    end
  end
end
