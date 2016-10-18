require 'spec_helper'

describe Yelp::Response::Base do
  describe '#initialize' do
    let(:json) { {'a' => 10, 'b' => 20} }

    subject(:base) { Yelp::Response::Base.new(json) }

    it { is_expected.to be_a Yelp::Response::Base }

    it 'should create variables' do
      expect(base.instance_variable_get('@a')).to eql 10
      expect(base.instance_variable_get('@b')).to eql 20
    end
  end

  describe '#initialize nil' do
    subject(:base) { Yelp::Response::Base.new(nil) }

    it { is_expected.to be_a Yelp::Response::Base }
  end
end
