require 'spec_helper'

describe Yelp::Endpoint::PhoneSearch do
  include_context 'shared configuration'

  let(:api_keys) { real_api_keys }
  let(:phone) { '+14159083801' }
  let(:options) { { code: 'US', category: 'localflavor' } }
  let(:client) { Yelp::Client.new(api_keys) }

  describe '#phone_search' do
    subject(:results) {
      VCR.use_cassette('phone_search') do
        client.phone_search(phone, options)
      end
    }

    it { should be_a(BurstStruct::Burst) }
    it 'should get results' do
      expect(results.businesses.size).to be > 0
    end
  end

  describe 'errors' do
    it_behaves_like 'a request error' do
      let(:request) { client.phone_search(phone) }
    end
  end
end
