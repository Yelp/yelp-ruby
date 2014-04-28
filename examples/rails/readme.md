# Rails + Yelp

This is a sample Rails application using the Ruby gem. To check it out in action, visit [http://rails-yelp.herokuapp.com/](http://rails-yelp.herokuapp.com/).

## Usage

The key take away here is that you'll want to place an initializer inside of ``config/initializers`` that set's up the keys for the gem.

```
# inside of config/initializers/yelp.rb

Yelp.client.configure do |config|
  config.consumer_key = YOUR_CONSUMER_KEY
  config.consumer_secret = YOUR_CONSUMER_SECRET
  config.token = YOUR_TOKEN
  config.token_secret = YOUR_TOKEN_SECRET
end

```

Now you can use the a pre-initialized client anywhere in the app:

```
# inside of a HomeController
# app/controllers/home_controller.rb

class HomeController < ApplicationController
  # ...

  def search
    parameters = { term: params[:term], limit: 16 }
    render json: Yelp.client.search('San Francisco', parameters)
  end
end

```