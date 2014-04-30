module Yelp
  module Error
    def self.check_for_error(request)
      # Check if the status is in the range of non-error status codes
      return if (200..399).include?(request.status)

      body = JSON.parse(request.body)
      @error_classes ||= Hash.new do |hash, key|
        class_name = key.split('_').map(&:capitalize).join('').gsub('Oauth', 'OAuth')
        hash[key] = Yelp::Error.const_get(class_name)
      end

      klass = @error_classes[body['error']['id']]
      raise klass.new(body['error']['text'])
    end

    class Base < StandardError; end

    class AlreadyConfigured < Base
      def initialize(msg = 'Gem cannot be reconfigured.  Initialize a new ' +
          'instance of Yelp::Client.')
        super
      end
    end

    class MissingAPIKeys < Base
      def initialize(msg = "You're missing an API key")
        super
      end
    end

    class MissingLatLng < Base
      def initialize(msg = 'Missing required latitude or longitude parameters')
        super
      end
    end

    class BoundingBoxNotComplete < Base
      def initialize(msg = 'Missing required values for bounding box')
        super
      end
    end

    class InternalError           < Base; end
    class ExceededRequests        < Base; end
    class MissingParameter        < Base; end
    class InvalidParameter        < Base; end
    class InvalidSignature        < Base; end
    class InvalidOAuthCredentials < Base; end
    class InvalidOAuthUser        < Base; end
    class AccountUnconfirmed      < Base; end
    class UnavailableForLocation  < Base; end
    class AreaTooLarge            < Base; end
    class MultipleLocations       < Base; end
    class BusinessUnavailable     < Base; end
  end
end
