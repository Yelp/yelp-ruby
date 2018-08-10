shared_context "shared configuration" do
  let(:valid_api_keys) { Hash[api_key: 'abc'] }
  let(:real_api_keys) { Hash[api_key: ENV['YELP_AUTH_TOKEN']] }
  let(:invalid_api_keys) { valid_api_keys.merge(api_key: nil) }
end