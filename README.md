# ActiveRecordMask

ActiveRecordMask is a small ruby library that provides an easy way to mask read access to database attributes and associations in ActiveRecord objects. 

It allows you to configure default or empty values with configuration on a per-model basis.

## Simple example

```ruby
some_object = SomeClass.first

some_object.title == 'Real Title'
=> false

some_object.title == 'some configured default'
=> true

# Allow reading of real data.
some_object.mask_down!

some_object.title == 'Real Title'
=> true

# Prevent reading of real data.
some_object.mask_up!

some_object.title == 'Real Title'
=> false

```

## Features

- Whitelist attributes and associations that should be returned by default.
- Define custom default values for attributes.
- Toggle between showing real data or default values.
- All configurable per model.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record_mask'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install active_record_mask
```

## Usage

### Basic configuration

Include the `ActiveRecordMask` module in your ActiveRecord model and use the `configure_active_record_mask` block to set up the configuration.

```ruby
class SomeClass < ActiveRecord::Base
  include ActiveRecordMask

  has_many :another_classes
  
  # ActiveRecordMask configuration
  configure_active_record_mask do |config|
    config.show_real_data_by_default(false)
    config.allow_attributes([:id])
    # config.allow_associations([:another_classes])
    config.revealed_defaults({ title: 'hidden' })
  end
end
```



### Configuration options

- `show_real_data_by_default`: Set to `true` if you want real data to be shown by default, without calling `mask_down!`. Default: `false`

- `revealed_defaults`: Define custom default values for specific attributes. It accepts a attribute-name value hash. Default: `{}`

- `allow_attributes`: Define a list of attributes that should not be protected. Default: `[:id]`

- `allow_associations`: Define a list of associations that should not be protected. Default: `[]`

## Testing
```ruby
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome: [https://github.com/sventantau/active_record_mask](https://github.com/sventantau/active_record_mask)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
