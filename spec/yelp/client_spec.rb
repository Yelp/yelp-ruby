require 'yelp'

describe Yelp::Client do
  describe 'client initialization' do
    it 'should create a client with the appropriate keys set' do
      keys = { consumer_key: 'abc',
               consumer_secret: 'def',
               token: 'ghi',
               token_secret: 'jkl' }

      client = Yelp::Client.new(keys)
      Yelp::Client::AUTH_KEYS.each do |key|
        client.send(key).should eql keys[key]
      end
    end
  end
end
