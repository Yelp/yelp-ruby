require 'spec_helper'

describe Yelp::Response::Base do
  describe '#initialize' do
    let(:json) { Hash['a' => 10,
                      'b' => 20,
                      'rating_image_url' => 'http://somefakewebsite.com',
                      'rating_img_url' => 'http://someotherfakewebsite.com'] }

    subject(:base) { base = Yelp::Response::Base.new(json) }

    it { should be_a(Yelp::Response::Base) }

    it 'should create variables' do
      expect(base.instance_variable_get('@a')).to eql 10
      expect(base.instance_variable_get('@b')).to eql 20
    end

    it 'should skip variables in SKIP' do
      expect(base.instance_variable_get('@rating_image_url')).to be nil
      expect(base.instance_variable_get('@rating_img_url')).to be nil
    end
  end

  describe '#initialize nil' do
    subject(:base) { Yelp::Response::Base.new(nil) }

    it { should be_a(Yelp::Response::Base) }
  end
end
