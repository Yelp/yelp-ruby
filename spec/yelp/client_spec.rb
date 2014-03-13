require 'yelp'
require 'pry'

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

  describe 'oauth authorization' do
    it 'should set the appropriate values for oauth' do
      @client.configure

      @client.consumer_key.should eql keys[:consumer_key]
      @client.consumer_secret.should eql keys[:consumer_secret]
      @client.token_secret.should eql keys[:token_secret]
      @client.token.should eql keys[:token]
    end
  end
end
