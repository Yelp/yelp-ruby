require 'yelp/version'
require 'yelp/client'

module Yelp
  # Returns an initially-unconfigured instance of the client.
  # @return [Client] an instance of the client
  #
  # @example Configuring and using the client
  #   Yelp.client.configure do |config|
  #     config.consumer_key = 'abc'
  #     config.consumer_secret = 'def'
  #     config.token = 'ghi'
  #     config.token_secret = 'jkl'
  #   end
  #
  #   Yelp.client.search('San Francisco', { term: 'food' })
  #
  def self.client
    @client ||= Yelp::Client.new
  end
end
