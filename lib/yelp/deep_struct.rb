require 'ostruct'

# This is some code to create nested Structs from nested hash tables.
# Code written by Andrea Pavoni, more information here:
# http://andreapavoni.com/blog/2013/4/create-recursive-openstruct-from-a-ruby-hash
class DeepStruct < OpenStruct
  def initialize(hash = nil)
    @table = {}
    @hash_table = {}

    if hash
      hash.each do |k,v|
        @table[k.to_sym] = (v.is_a?(Hash) ? self.class.new(v) : v)
        @hash_table[k.to_sym] = v

        new_ostruct_member(k)
      end
    end
  end

  def to_h
    @hash_table
  end
end
