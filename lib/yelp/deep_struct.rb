require 'ostruct'

# This is some code to create nested Structs from nested hash tables.
# Code written by Andrea Pavoni, more information here:
# http://andreapavoni.com/blog/2013/4/create-recursive-openstruct-from-a-ruby-hash
#
# This has been slightly modified to work with hashes nested inside of arrays
class DeepStruct < OpenStruct
  def initialize(hash = {})
    @table = {}

    hash.each do |k,v|
      if v.is_a?(Hash)
        @table[k.to_sym] = self.class.new(v)
      elsif v.is_a?(Array)
        array = []
        v.each do |v2|
          if v2.is_a?(Hash)
            array << self.class.new(v2)
          else
            array << v2
          end
        end
        @table[k.to_sym] = array
      else
        @table[k.to_sym] = v
      end

      new_ostruct_member(k)
    end
  end
end
