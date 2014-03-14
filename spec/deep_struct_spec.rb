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

    object = DeepStruct.new(hash)
    object.foo.should eql 1
    object.bar.baz.should eql 2
    object.bar.bender.bending.rodriguez.should eql true
    object.fry[0].past.should eql true
    object.fry[1].present.should eql true
    object.fry[2].future.should eql true
    object.turunga.should eql 'leela'
    object.hubert.should eql 'farnsworth'
    object.zoidberg.size.should eql 3
    object.zoidberg[0].should eql 'doctor'
  end
end
