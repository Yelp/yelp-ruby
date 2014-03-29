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

  subject(:deep_struct) { DeepStruct.new(hash) }

  it 'turns top level into a struct' do
    expect(deep_struct.foo).to eql 1
  end

  it 'recursively creates structs all the way down the hash' do
    expect(deep_struct.bar.baz).to equal 2
    expect(deep_struct.bar.bender.bending.rodriguez).to eql true
  end

  it 'correctly creates arrays with hashes into new structs' do
    expect(deep_struct.fry[0].past).to eql true
    expect(deep_struct.fry[1].present).to eql true
    expect(deep_struct.fry[2].future).to eql true
  end

  it 'turns string keys into structs' do
    expect(deep_struct.hubert).to eql 'farnsworth'
  end

  it 'should maintain arrays with non hashes' do
    expect(deep_struct.zoidberg.size).to eql 3
    expect(deep_struct.zoidberg[0]).to eql 'doctor'
  end
end
