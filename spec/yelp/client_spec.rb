require 'spec_helper'

describe Yelp::Client do
  include_context 'shared configuration'

  let(:client) { Yelp::Client.new(configuration) }
  let(:api_keys) { valid_api_keys }

  describe '#initialize' do
    context 'with valid configuration' do
      it 'should pass the configuration through' do
        expect(client.configuration).to eql(configuration)
      end
    end

    context 'with invalid configuration' do
      let(:api_keys) { invalid_api_keys }

      it 'should raise an error when configuration is invalid' do
        expect{ client }.to raise_error
      end
    end
  end

  describe '#configure' do
    subject { client.configuration }
    let(:client) { Yelp::Client.new }

    context 'with valid configuration' do
      before {
        client.configure do |config|
          valid_api_keys.each { |key, value| config.send("#{key}=", value) }
        end
      }

      it 'should set the configuration values' do
        valid_api_keys.each do |key, value|
          expect(client.configuration.send(key)).to eql(value)
        end
      end

      it { should be_a(Yelp::Configuration) }
    end

    context 'with invalid configuration' do
      it 'should raise an error' do
        expect{
          client.configure do |config|
            invalid_api_keys.each { |key, value| config.send("#{key}=", value) }
          end
        }.to raise_error
      end
    end
  end

  describe '#connection' do
    let(:client) { Yelp::Client.new }

    context 'without configuration' do
      it 'should raise an error' do
        expect{ client.connection }.to raise_error
      end
    end
  end
end
