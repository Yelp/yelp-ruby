require 'spec_helper'

describe Yelp do
  describe "#client" do
    subject { Yelp.client }

    it { should be_a(Yelp::Client) }
    its(:configuration) { should be_nil }
  end
end