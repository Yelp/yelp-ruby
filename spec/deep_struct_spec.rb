require 'yelp/deep_struct'

describe DeepStruct do
  it 'should create deeply nested structs from nested hash tables' do
    hash = { foo: 1,
             bar: {
               baz: 2,
               bender: {
                 bending: {
                   rodriguez: true
                 }
               }
             },
             fry: 4 }

    object = DeepStruct.new(hash)
    object.foo.should eql 1
    object.bar.baz.should eql 2
    object.bar.bender.bending.rodriguez.should eql true
    object.fry.should eql 4
  end
end
