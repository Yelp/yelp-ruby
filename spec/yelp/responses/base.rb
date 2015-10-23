require 'spec_helper'

describe Yelp::Response::Base do
  include_context 'shared configuration'

  describe '#initialize' do
    let(:json) { Hash.new(['a', 10],
                          ['b', 20]) }

    it 'should create instance variables from json' do
      base = Yelp::Response::Base.new(json)
      expect { base.instance_variable_get('@a') }.to be 10
      expect { base.instance_variable_get('@b') }.to be 20
    end
  end
end
