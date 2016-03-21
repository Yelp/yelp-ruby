require 'spec_helper'

describe Yelp::Endpoint::Business do
  include_context 'shared configuration'

  let(:api_keys) { real_api_keys }
  let(:business) { 'yelp-san-francisco' }
  let(:client) { Yelp::Client.new(api_keys) }
  let(:locale) { Hash[lang: 'fr'] }

  describe '#business' do
    subject {
      VCR.use_cassette('business') do
        client.business(business)
      end
    }

    it { should be_a(Yelp::Response::Business) }
    its('business.name') { should eql('Yelp') }
    its('business.url') { should include('yelp.com') }
  end

  describe '#business locale' do
    subject {
      VCR.use_cassette('business_locale') do
        client.business(business, locale)
      end
    }

    it { should be_a(Yelp::Response::Business) }
    its('business.name') { should eql('Yelp') }
    its('business.url') { should include('yelp.fr') }
  end

  describe 'errors' do
    it_behaves_like 'a request error' do
      let(:request) { client.business(business) }
    end
  end
end
