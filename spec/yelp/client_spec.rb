require 'spec_helper'

describe Yelp::Client do
  include_context 'shared configuration'

  let(:client) { Yelp::Client.new(api_keys) }
  let(:api_keys) { valid_api_keys }

  def configure_client_with_api_keys(api_keys)
    client.configure do |config|
      api_keys.each { |key, value| config.send("#{key}=", value) }
    end
  end

  describe '#initialize' do
    subject { client }

    context 'with valid configuration' do
      its(:configuration) { should be_a(Yelp::Configuration) }
      its(:configuration) { should be_frozen }

      it 'should not be reconfigurable' do
        expect {
          configure_client_with_api_keys(valid_api_keys)
        }.to raise_error
      end
    end

    context 'with invalid configuration' do
      let(:api_keys) { invalid_api_keys }

      it 'should raise an error when configuration is invalid' do
        expect { client }.to raise_error
      end
    end
  end

  describe '#configure' do
    subject { client.configuration }
    let(:client) { Yelp::Client.new }

    context 'with valid configuration' do
      before { configure_client_with_api_keys(api_keys) }

      it 'should set the configuration values' do
        valid_api_keys.each do |key, value|
          expect(client.configuration.send(key)).to eql(value)
        end
      end

      it 'should not be reconfigurable' do
        expect { configure_client_with_api_keys(valid_api_keys) }.to raise_error
      end

      it { should be_a(Yelp::Configuration) }
      it { should be_frozen }
    end

    context 'with invalid configuration' do
      it 'should raise an error' do
        expect { configure_client_with_api_keys(invalid_api_keys) }.to raise_error
      end
    end
  end

  describe '#connection' do
    let(:client) { Yelp::Client.new }

    context 'without configuration' do
      it 'should raise an error' do
        expect { client.connection }.to raise_error
      end
    end
  end
end
