module Yelp
  class Error < StandardError; end
  class MissingAPIKeys < Error; end
  class MissingLatLng < Error; end
  class BoundingBoxNotComplete < Error; end
end
