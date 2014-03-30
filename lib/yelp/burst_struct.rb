module BurstStruct
  module BurstArrayMixin
    def [](index)
      self[index] = BurstStruct::Burst.new(self.at(index)) if self.at(index).is_a?(Hash)
      super
    end
  end

  class Burst
    def initialize(hash = {})
      @hash = hash
    end

    def method_missing(method_name, *arguments, &block)
      key = find_key(method_name)

      if key
        return_or_build_struct(key)
      else
        super
      end
    end

    def respond_to?(method_name, include_private = false)
      @hash.keys.include? method_name || super
    end

    def return_or_build_struct(method_name)
      return Burst.new(@hash[method_name]) if @hash[method_name].is_a?(Hash)
      @hash[method_name].extend(BurstArrayMixin) if @hash[method_name].is_a?(Array)
      @hash[method_name]
    end

    def find_key(method_name)
      return method_name.to_sym if @hash.keys.include? method_name.to_sym
      return method_name.to_s   if @hash.keys.include? method_name.to_s
    end
  end
end
