require 'yelp'

describe Yelp::Client do
  let(:keys) { Hash[consumer_key: 'abc',
                    consumer_secret: 'def',
                    token: 'ghi',
                    token_secret: 'jkl'] }
  let(:client) { Yelp::Client.new(keys) }

  describe 'client initialization' do
    it 'should create a client with the appropriate keys set' do
      Yelp::Client::AUTH_KEYS.each do |key|
        client.send(key).should eql keys[key]
      end
    end
  end

  describe 'errors' do
    it 'should raise an error when missing a key' do
      bad_keys = keys
      bad_keys[:consumer_key] = nil

      lambda {
        Yelp::Client.new(bad_keys)
      }.should raise_error
    end
  end
end
