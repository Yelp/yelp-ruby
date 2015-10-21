module Model
  class Base
    def initialize(json)
      json.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
