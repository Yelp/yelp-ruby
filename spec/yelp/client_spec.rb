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

  describe 'oauth authorization' do
    it 'should successfully create an oauth client with the appropriate values set' do
      @client.authorize

      @client.access_token.class.should eql OAuth::AccessToken

      @client.access_token.consumer.options[:site].should eql Yelp::Client::API_HOST
      @client.access_token.consumer.key.should eql keys[:consumer_key]
      @client.access_token.consumer.secret.should eql keys[:consumer_secret]

      @client.access_token.secret.should eql keys[:token_secret]
      @client.access_token.token.should eql keys[:token]
    end
  end
end
