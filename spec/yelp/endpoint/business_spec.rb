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
    context 'API' do
      let(:response_body) { "{\"error\": {\"text\": \"error message\", \"id\": \"INTERNAL_ERROR\"}}" }
      let(:bad_response)  { double('response', status: 400, body: response_body) }

      it 'should raise an error' do
        client.stub_chain(:connection, :get).and_return(bad_response)
        expect { client.business(business) }.to raise_error(Yelp::InternalError)
      end
    end
  end
end
