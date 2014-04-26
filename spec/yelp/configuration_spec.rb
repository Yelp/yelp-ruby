require 'spec_helper'

describe Yelp::Configuration do
  include_context 'shared configuration'

  let(:api_keys) { valid_api_keys }

  describe '#auth_keys' do
    subject { configuration.auth_keys }
    it { should eql(api_keys) }
  end

  describe "#valid?" do
    subject { configuration.valid? }

    context "when keys are valid" do
      it { should be_true }
    end

    context "when keys are not set" do
      let(:api_keys) { Hash.new }
      it { should be_false }
    end

    context "when a key is an empty string" do
      let(:api_keys) { valid_api_keys.merge(consumer_key: '') }
      it { should be_false }
    end

    context "when a key is nil" do
      let(:api_keys) { valid_api_keys.merge(token: nil) }
      it { should be_false }
    end
  end
end
