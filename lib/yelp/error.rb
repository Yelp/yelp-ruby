module Yelp
  class Error < StandardError
    def self.check_for_error(data)
      return if data.status == 200

      body = JSON.parse(data.body)
      klass = case body['error']['id']
              when 'INTERNAL_ERROR'             then Yelp::InternalError
              when 'EXCEEDED_REQS'              then Yelp::ExceededRequests
              when 'MISSING_PARAMETER'          then Yelp::MissingParameter
              when 'INVALID_PARAMETER'          then Yelp::InvalidParameter
              when 'INVALID_SIGNATURE'          then Yelp::InvalidSignature
              when 'INVALID_OAUTH_CREDENTIALS'  then Yelp::InvalidOAuthCredentials
              when 'INVALID_OAUTH_USER'         then Yelp::InvalidOAuthUser
              when 'ACCOUNT_UNCONFIRMED'        then Yelp::AccountUnconfirmed
              when 'UNAVAILABLE_FOR_LOCATION'   then Yelp::UnavailableForLocation
              when 'AREA_TOO_LARGE'             then Yelp::AreaTooLarge
              when 'MULTIPLE_LOCATIONS'         then Yelp::MultipleLocations
              when 'BUSINESS_UNAVAILABLE'       then Yelp::BusinessUnavailable
              end

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
