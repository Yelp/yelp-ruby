require 'spec_helper'

describe Yelp::Configuration do
  include_context 'shared configuration'

  let(:api_keys) { valid_api_keys }
  let(:configuration) { Yelp::Configuration.new(api_keys) }

  describe '#initialize' do
    subject { configuration }

    Yelp::Configuration::AUTH_KEYS.each do |auth_key|
      its(auth_key) { should eql(api_keys[auth_key]) }
    end
  end

  describe '#auth_keys' do
    subject { configuration.auth_keys }
    it { should eql(api_keys) }
  end

  describe "#valid?" do
    subject { configuration.valid? }

    context "when keys are valid" do
      it { should be true }
    end

    context "when keys are not set" do
      let(:api_keys) { Hash.new }
      it { should be false }
    end

    context "when a key is an empty string" do
      let(:api_keys) { valid_api_keys.merge(consumer_key: '') }
      it { should be false }
    end

    context "when a key is nil" do
      let(:api_keys) { valid_api_keys.merge(token: nil) }
      it { should be false }
    end
  end
end
