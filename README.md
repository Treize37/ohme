# Ohme

A Ruby connector for the Ohme API, a tool for integrating with the Ohme CRM platform. This gem simplifies interaction with the Ohme API, allowing developers to easily perform operations such as retrieving data, creating resources, and managing entities within the Ohme ecosystem.

## Installation

Install the gem and add to the application's Gemfile by executing:

    bundle add ohme

If bundler is not being used to manage dependencies, install the gem by executing:

    gem install ohme

## Usage

### Configuration Initialization

First, configure the Ohme client with your credentials and settings:

```ruby
require 'ohme'
require 'json'

config = Ohme::Configuration.new do |c|
  c.client_name = 'your_client_name'
  c.client_secret = 'your_client_secret'
end
```

Then, initialize the client using your configuration:

```ruby
client = Ohme::Client.new(config)
```

You can now use the API endpoints. For example, to list contacts:

```ruby
contact_api = Ohme::API::Contact.new(client)
contacts = contact_api.index
puts contacts
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/Treize37/ohme>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Treize37/ohme/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ohme project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Treize37/ohme/blob/main/CODE_OF_CONDUCT.md).
