require 'spec_helper'
require 'yelp'

describe Yelp::Endpoint::Business do
  let(:keys) { Hash[consumer_key: ENV['YELP_CONSUMER_KEY'],
                    consumer_secret: ENV['YELP_CONSUMER_SECRET'],
                    token: ENV['YELP_TOKEN'],
                    token_secret: ENV['YELP_TOKEN_SECRET']] }
  let(:business) { 'yelp-san-francisco' }
  let(:client) { Yelp::Client.new(keys) }

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
