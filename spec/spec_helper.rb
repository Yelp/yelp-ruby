require 'yelp'
require 'rspec/its'
require 'support/request_error'
require 'support/shared_configuration'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock

  c.filter_sensitive_data('<YELP_CONSUMER_KEY>') { ENV['YELP_CONSUMER_KEY'] }
  c.filter_sensitive_data('<YELP_CONSUMER_SECRET>') { ENV['YELP_CONSUMER_SECRET'] }
  c.filter_sensitive_data('<YELP_TOKEN>') { ENV['YELP_TOKEN'] }
  c.filter_sensitive_data('<YELP_TOKEN_SECRET>') { ENV['YELP_TOKEN_SECRET'] }
end
