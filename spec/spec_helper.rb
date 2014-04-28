require 'yelp'
require 'support/shared_configuration'
require 'yelp/error/request_error_spec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end
