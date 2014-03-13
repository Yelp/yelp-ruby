require 'yelp'

describe Yelp::Client do
  let(:keys) { Hash[consumer_key: 'abc',
                    consumer_secret: 'def',
                    token: 'ghi',
                    token_secret: 'jkl'] }

  before do
    @client = Yelp::Client.new(keys)
  end

  describe 'client initialization' do
    it 'should create a client with the appropriate keys set' do
      Yelp::Client::AUTH_KEYS.each do |key|
        @client.send(key).should eql keys[key]
      end
    end
  end
end
