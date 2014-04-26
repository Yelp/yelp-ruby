# yelp-ruby

This is a Ruby Gem for the Yelp API. It'll simplifies the process of consuming data from the Yelp API for developers using Ruby. The library encompasses both Search and Business API functions.

## Installation

Add this line to your application's Gemfile:

    gem 'yelp', require: 'yelp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yelp

## Usage

### Basic usage

The gem uses a client model to query against the API. You create and configure a client with your API keys and make requests through that.

```
require 'yelp'

client = Yelp::Client.new({ consumer_key: YOUR_CONSUMER_KEY,
                            consumer_secret: YOUR_CONSUMER_SECRET,
                            token: YOUR_TOKEN,
                            token_secret: YOUR_TOKEN_SECRET
                          })
```

Alternatively, you can also globally configure the client using a configure
block, and access a client singleton using `Yelp.client`.  If you intend to
use the gem with Rails, the client should be configured in an initializer.

```
require 'yelp'

Yelp.client.configure do |config|
  config.consumer_key = YOUR_CONSUMER_KEY
  config.consumer_secret = YOUR_CONSUMER_SECRET
  config.token = YOUR_TOKEN
  config.token_secret = YOUR_TOKEN_SECRET
end

Yelp.client.search('San Francisco', { term: 'food' })
```

After creating the client you're able to make requests to either the Search API or Business API. Note: all four keys are required for making requests against the Yelp API. If you need any keys sign up and get access from [http://www.yelp.com/developers](http://www.yelp.com/developers).

### [Search API](http://www.yelp.com/developers/documentation/v2/search_api)

Once you have a client you can use ``#search`` to make a request to the Search API.

```
client.search('San Francisco')
```

You can also pass in general params and locale options to the method as hashes

```
params = { term: 'food',
           limit: 3,
           category_filter: 'discgolf'
         }

locale = { lang: 'fr' }

client.search('San Francisco', params, locale)
```

Key names and options for params and locale match the documented names on the [Yelp Search API](http://www.yelp.com/developers/documentation/v2/search_api)

Additionally there are two more search methods for searching by a [bounding box](http://www.yelp.com/developers/documentation/v2/search_api#searchGBB) or for [geographical coordinates](http://www.yelp.com/developers/documentation/v2/search_api#searchGC):

```
# bounding box
bounding_box = { sw_latitude: 37.7577, sw_longitude: -122.4376, ne_latitude: 37.785381, ne_longitude: -122.391681 }
client.search_by_bounding_box(bounding_box, params, locale)

# coordinates
coordinates = { latitude: 37.7577, longitude: -122.4376 }
client.search_by_coordinates(coordinates, params, locale)
```

### [Business API](http://www.yelp.com/developers/documentation/v2/business)

To use the Business API after you have a client you just need to call ``#business`` with a business id

```
client.business('yelp-san-francisco')
```

You can pass in locale information as well

```
locale = { lang: 'fr' }

client.business('yelp-san-francisco', locale)
```

## Responses

Responses from the API are all parsed and converted into Ruby objects. You're able to access information using dot-notation

```
## search
response = client.search('San Francisco')

response.businesses
# [<Business 1>, <Business 2>, ...]

response.businesses[0].name
# "Kim Makoi, DC"

response.businesses[0].rating
# 5.0


## business
response = client.business('yelp-san-francisco')

response.name
# Yelp

response.categories
# [["Local Flavor", "localflavor"], ["Mass Media", "massmedia"]]
```

For specific response values check out the docs for the [search api](http://www.yelp.com/developers/documentation/v2/search_api#rValue) and the [business api](http://www.yelp.com/developers/documentation/v2/business#rValue)

## Contributing

1. Fork it ( http://github.com/yelp/yelp-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Git Workflow

We are using the [git flow](http://nvie.com/posts/a-successful-git-branching-model/)
workflow. Atlassian has a [solid overview](https://www.atlassian.com/git/workflows#!workflow-gitflow).
Essentially, new development is merged into the develop branch from feature
branches, then merged from develop to a release branch, then to master from
the release branch. Master should always contain the most recently released
version of the gem.
