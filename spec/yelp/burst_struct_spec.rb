require 'yelp/burst_struct'

describe BurstStruct::Burst do
  describe '#keys' do
    subject(:struct) { BurstStruct::Burst.new(foo: 'bar', baz: 'qux') }

    it 'should return' do
      expect(struct.keys).to eql [:foo, :baz]
    end
  end

  describe '#foo' do
    subject(:struct) { BurstStruct::Burst.new(foo: 'bar') }

    context 'when a key exists' do
      it 'should return' do
        expect(struct.foo).to eql 'bar'
      end

      it { should have_key(:foo) }
      it { should have_key('foo') }

      it { should respond_to(:foo) }
    end

    context 'when a key does not exist' do
      it 'should not respond to it' do
        expect(struct.respond_to? :super_foo).to eql false
      end

      it { should_not have_key(:super_foo) }
      it { should_not have_key('super_foo') }
    end
  end

  context 'n deep nested hash' do
    let(:hash) { Hash[ futurama: { characters: { robots: { best: 'bender' } } } ] }

    subject(:struct) { BurstStruct::Burst.new(hash) }

    describe '#foo#bar#baz#biz' do
      it 'should return' do
        expect(struct.futurama.characters.robots.best).to eql 'bender'
      end
    end
  end

  context 'arrays' do
    let(:hash) { Hash[ businesses: [ { name: 'Yelp', location: 'San Francisco' },
                                     { name: 'Ice Cream', flavor: 'Chocolate' },
                                     [ { name: 'Moe', occupation: 'Bartender' } ] ] ] }

    subject(:struct) { BurstStruct::Burst.new(hash) }

    describe '#businesses[0].name' do
      it 'should return' do
        expect(struct.businesses[0].name).to eql 'Yelp'
        expect(struct.businesses[0].location).to eql 'San Francisco'
      end
    end

    describe '#business[1].name' do
      it 'should return' do
        expect(struct.businesses[1].name).to eql 'Ice Cream'
        expect(struct.businesses[1].flavor).to eql 'Chocolate'
      end
    end

    describe 'nested arrays' do
      it 'should parse arrays all the way down' do
        expect(struct.businesses[2][0].name).to eql 'Moe'
      end
    end
  end

  context 'large hash' do
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

    subject(:struct) { BurstStruct::Burst.new(hash) }

    it 'turns top level into a struct' do
      expect(struct.foo).to eql 1
    end

    it 'recursively creates structs all the way down the hash' do
      expect(struct.bar.baz).to equal 2
      expect(struct.bar.bender.bending.rodriguez).to eql true
    end

    it 'creates arrays with hashes into new structs' do
      expect(struct.fry[0].past).to eql true
      expect(struct.fry[1].present).to eql true
      expect(struct.fry[2].future).to eql true
    end

    it 'turns string keys into structs' do
      expect(struct.hubert).to eql 'farnsworth'
    end

    it 'should maintain arrays with non hashes' do
      expect(struct.zoidberg.size).to eql 3
      expect(struct.zoidberg[0]).to eql 'doctor'
    end
  end

  context 'deserialize' do
    let(:hash) do
      { name: 'Bender', company: 'Yelp', title: 'Bending Engineer' }
    end

    subject(:struct) { BurstStruct::Burst.new(hash) }

    it 'should deserialize to the same json' do
      expect(struct.to_json).to eql hash.to_json
    end
  end

  context 'struct with string keys' do
    subject(:struct) { BurstStruct::Burst.new('foo' => 'bar') }

    context 'when a key exists' do
      it 'should return' do
        expect(struct.foo).to eql 'bar'
      end

      it { should have_key(:foo) }
      it { should have_key('foo') }

      it { should respond_to(:foo) }
    end
  end
end
