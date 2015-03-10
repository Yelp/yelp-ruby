module BurstStruct
  class Burst
    def initialize(hash = {})
      @hash = hash
    end

    def keys
      @hash.keys
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
      has_key?(method_name) || super
    end

    def self.convert_array(array)
      array.map do |item|
        case item
        when Hash
          Burst.new(item)
        when Array
          Burst.convert_array(item)
        else
          item
        end
      end
    end

    def to_json(options = {})
      JSON.generate(@hash)
    end

    def has_key?(method_name)
      !find_key(method_name).nil?
    end

    def raw_data
      @hash
    end

    private

    def return_or_build_struct(method_name)
      return Burst.new(@hash[method_name])           if @hash[method_name].is_a?(Hash)
      return Burst.convert_array(@hash[method_name]) if @hash[method_name].is_a?(Array)
      @hash[method_name]
    end

    def find_key(method_name)
      return method_name.to_sym if @hash.keys.include? method_name.to_sym
      return method_name.to_s   if @hash.keys.include? method_name.to_s
    end
  end
end
