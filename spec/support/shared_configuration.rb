shared_context "shared configuration" do
  let(:valid_api_keys) { Hash[consumer_key: 'abc',
                          consumer_secret: 'def',
                          token: 'ghi',
                          token_secret: 'jkl'] }
  let(:real_api_keys) { Hash[consumer_key: ENV['YELP_CONSUMER_KEY'],
                    consumer_secret: ENV['YELP_CONSUMER_SECRET'],
                    token: ENV['YELP_TOKEN'],
                    token_secret: ENV['YELP_TOKEN_SECRET']] }
  let(:invalid_api_keys) { valid_api_keys.merge(consumer_key: nil) }
end