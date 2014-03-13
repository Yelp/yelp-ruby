require 'yelp'

describe Yelp do
  it "should return true" do
    Yelp.client.should eql true
  end
end
