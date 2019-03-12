# OmniAuth Jama Connect

Jama Connect OAuth2 Strategy for OmniAuth

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-jama-connect'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-jama-connect

## Usage

Here's a quick example for adding the middleware to a Rails application (in `config/initializers/omniauth.rb`):

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :jama_connect, ENV["JAMA_CONNECT_CLIENT_ID"], ENV["JAMA_CONNECT_CLIENT_SECRET"], host: "https://YOUR_COMPANY.jamaland.com"
end
```

This will add an endpoint to your application at `/auth/jama_connect` that will being the OAuth flow.

In the callback controller, you can find the `token` and `refresh_token` on the Hash: `request.env['omniauth.auth']['credentials']`. Store these values for subsequent requests to the Jama Connect API.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JamaSoftware/omniauth-jama-connect.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
