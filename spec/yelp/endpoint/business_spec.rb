require 'spec_helper'

describe Yelp::Endpoint::Business do
  include_context 'shared configuration'

  let(:api_keys) { real_api_keys }
  let(:business) { 'yelp-san-francisco' }
  let(:client) { Yelp::Client.new(api_keys) }

  describe '#business' do
    subject {
      VCR.use_cassette('business') do
        client.business(business)
      end
    }

    it { should be_a(BurstStruct::Burst) }
    its(:name) { should eql('Yelp') }
  end

  describe 'errors' do
    it_behaves_like 'a request error' do
      let(:request) { client.business(business) }
    end
  end
end
