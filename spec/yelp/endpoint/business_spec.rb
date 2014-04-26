require 'spec_helper'
require 'yelp'

describe Yelp::Endpoint::Business do
  include_context 'shared configuration'

  let(:api_keys) { real_api_keys }
  let(:business) { 'yelp-san-francisco' }
  let(:client) { Yelp::Client.new(configuration) }

  describe '#business' do
    subject {
      VCR.use_cassette('business') do
        client.business(business)
      end
    }

    it { should be_a(BurstStruct::Burst) }
    its(:name) { should eql('Yelp') }
  end
end
