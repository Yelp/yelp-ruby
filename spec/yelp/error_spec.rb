require 'spec_helper'

describe Yelp::Error do
  context 'from_request' do
    let(:response_body) { '{"error": {"text": "error message", "id": "INTERNAL_ERROR"}}' }
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
      }.to raise_error(Yelp::Error::InternalError)
    end
  end

  context 'invalid parameter' do 
    let(:response_body) { '{"error": {"text": "One or more parameters are invalid in request", "id": "INVALID_PARAMETER", "field": "oauth_token"}}' }
    let(:bad_response)  { double('response', status: 400, body: response_body) }

    it 'should raise an invalid response error' do 
      expect {
        Yelp::Error.check_for_error(bad_response)
      }.to raise_error(Yelp::Error::InvalidParameter)
    end

    it 'should expose the field parameter' do
      expect {
        Yelp::Error.check_for_error(bad_response)
      }.to raise_error ('One or more parameters are invalid in request: oauth_token')

    end

    context 'when the API returns the error description' do
      let(:response_body) { '{"error": {"text": "One or more parameters are invalid in request", "id": "INVALID_PARAMETER", "field": "limit", "description": "Limit maximum is 20"}}' }

      it 'should expose more details about the invalid parameter' do
        expect {
          Yelp::Error.check_for_error(bad_response)
        }.to raise_error ('One or more parameters are invalid in request: limit. Description: Limit maximum is 20')
      end
    end
  end
end
