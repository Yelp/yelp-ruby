require 'spec_helper'

describe Yelp::Endpoint::Search do
  include_context 'shared configuration'

  let(:api_keys) { real_api_keys }
  let(:location) { 'San Francisco' }
  let(:params) { Hash[term: 'restaurants',
                      category_filter: 'discgolf'] }
  let(:client) { Yelp::Client.new(api_keys) }

  describe '#search' do
    subject(:results) {
      VCR.use_cassette('search') do
        client.search(location)
      end
    }

    it { should be_a(BurstStruct::Burst) }
    it 'should get results' do
      expect(results.businesses.size).to be > 0
    end
  end

  describe '#search_bounding_box' do
    let(:bounding_box) { Hash[sw_latitude: 37.7577,
                              sw_longitude: -122.4376,
                              ne_latitude: 37.785381,
                              ne_longitude: -122.391681] }

    subject(:results) {
      VCR.use_cassette('search_bounding_box') do
        client.search_by_bounding_box(bounding_box)
      end
    }

    it 'should get results' do
      expect(results.businesses.size).to be > 0
    end
  end

  describe '#search_by_coordinates' do
    let(:coordinates) { Hash[latitude: 37.7577,
                             longitude: -122.4376] }

    subject(:results) {
      VCR.use_cassette('search_by_coordinates') do
        client.search_by_coordinates(coordinates)
      end
    }

    it 'should get results' do
      expect(results.businesses.size).to be > 0
    end
  end

  describe 'errors' do
    context 'search' do
      it 'raises when #search_by_coordinates params are empty' do
        expect { client.search_by_coordinates({}, params) }.to raise_error(Yelp::Error::MissingLatLng)
      end

      it 'raises when #search_by_bounding_box params are empty' do
        expect { client.search_by_bounding_box({}, params) }.to raise_error(Yelp::Error::BoundingBoxNotComplete)
      end
    end

    it_behaves_like 'a request error' do
      let(:request) { client.search(location) }
    end
  end
end
