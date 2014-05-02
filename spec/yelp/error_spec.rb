require 'spec_helper'

describe Yelp::Error do
  context '#from_request' do
    let(:response_body) { "{\"error\": {\"text\": \"error message\", \"id\": \"INTERNAL_ERROR\"}}" }
    let(:good_response) { double('response', status: 200) }
    let(:bad_response)  { double('response', status: 400, body: response_body) }

    it 'should not raise an error' do
      expect {
        Yelp::Error.check_for_error(good_response)
      }.to_not raise_error
    end

    it 'should raise an internal error' do
      expect {
        Yelp::Error.check_for_error(bad_response)
      }.to raise_error(Yelp::Error::InternalError, 'error message')
    end
  end
end
