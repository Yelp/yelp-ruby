module Yelp
  class Error < StandardError; end

  class MissingAPIKeys < Error
    def initialize(msg = "You're missing an API key")
      super
    end
  end

  class MissingLatLng < Error
    def initialize(msg = 'Missing required latitude or longitude parameters')
      super
    end
  end

  class BoundingBoxNotComplete < Error
    def initialize(msg = 'Missing required values for bounding box')
      super
    end
  end
end
