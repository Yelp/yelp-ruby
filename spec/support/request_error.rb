shared_examples 'a request error' do
  context 'API' do
    let(:response_body) { "{\"error\": {\"text\": \"error message\", \"id\": \"INTERNAL_ERROR\"}}" }
    let(:bad_response)  { double('response', status: 400, body: response_body) }

    it 'should raise an error' do
      client.stub_chain(:connection, :get).and_return(bad_response)
      expect { request }.to raise_error(Yelp::Error::InternalError)
    end
  end
end
