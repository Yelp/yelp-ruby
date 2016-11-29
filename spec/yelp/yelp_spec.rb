require 'spec_helper'

describe Yelp do
  describe '::client' do
    subject { Yelp.client }

    it { is_expected.to be_a Yelp::Client }
    its(:configuration) { is_expected.to be nil }
  end
end
