require 'spec_helper'

describe Yelp::Endpoint::Business do
  include_context 'shared configuration'

  let(:api_keys) { real_api_keys }
  let(:business) { 'yelp-san-francisco' }
  let(:client) { Yelp::Client.new(api_keys) }
  let(:locale) { {lang: 'fr'} }

  describe '#business' do
    subject {
      VCR.use_cassette('business') do
        client.business(business)
      end
    }

    it { is_expected.to be_a(Yelp::Response::Business) }
    its('business.name') { is_expected.to eql('Yelp') }
    its('business.url') { is_expected.to include('yelp.com') }

    context 'with locale' do
      subject {
        VCR.use_cassette('business_locale') do
          client.business(business, locale)
        end
      }

      it { is_expected.to be_a(Yelp::Response::Business) }
      its('business.name') { is_expected.to eql('Yelp') }
      its('business.url') { is_expected.to include('yelp.fr') }
    end
  end

  describe 'errors' do
    it_behaves_like 'a request error' do
      let(:request) { client.business(business) }
    end
  end
end
