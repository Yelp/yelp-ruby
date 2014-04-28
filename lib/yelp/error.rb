module Yelp
  class Error < StandardError
    def self.check_for_error(data)
      # Check if the status is in the range of non-error status codes
      return if (200..399).include?(data.status)

      body = JSON.parse(data.body)
      @error_classes ||= Hash.new do |hash, key|
        class_name = key.split('_').map(&:capitalize).join('').gsub('Oauth', 'OAuth')
        hash[key] = Yelp.const_get(class_name)
      end

      klass = error_classes[body['error']['id']]
      raise klass.new(body['error']['text'])
    end
  end

  class AlreadyConfigured < Error
    def initialize(msg = 'Gem cannot be reconfigured.  Initialize a new ' +
        'instance of Yelp::Client.')
      super
    end
  end

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

  class InternalError           < Error; end
  class ExceededRequests        < Error; end
  class MissingParameter        < Error; end
  class InvalidParameter        < Error; end
  class InvalidSignature        < Error; end
  class InvalidOAuthCredentials < Error; end
  class InvalidOAuthUser        < Error; end
  class AccountUnconfirmed      < Error; end
  class UnavailableForLocation  < Error; end
  class AreaTooLarge            < Error; end
  class MultipleLocations       < Error; end
  class BusinessUnavailable     < Error; end
end
