require 'yelp/deep_struct'

describe DeepStruct do
  let(:hash) do
    { foo: 1,
      bar: {
        baz: 2,
        bender: {
          bending: {
            rodriguez: true
          }
        }
      },
      fry: [
        {past: true},
        {present: true},
        {future: true}
      ],
      turunga: 'leela',
      'hubert' => 'farnsworth',
      zoidberg: [
        'doctor',
        'homeowner',
        'moviestar'
      ]
    }
  end

  before(:each) do
    @object = DeepStruct.new(hash)
  end

  it 'should turn top level into a struct' do
    @object.foo.should eql 1
  end

  it 'should recursively create structs all the way down the hash' do
    @object.bar.baz.should eql 2
    @object.bar.bender.bending.rodriguez.should eql true
  end

  it 'should correctly create arrays with hases into new structs' do
    @object.fry[0].past.should eql true
    @object.fry[1].present.should eql true
    @object.fry[2].future.should eql true
  end

  it 'should turn string keys into structs' do
    @object.hubert.should eql 'farnsworth'
  end

  it 'should maintain arrays with non hashes' do
    @object.zoidberg.size.should eql 3
    @object.zoidberg[0].should eql 'doctor'
  end
end
