# HashGenerator

Simple programmatic building of hashes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hash_generator'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install hash_generator
```

## Usage

Use `#store` to store primitive values:

```ruby
require 'hash_generator'

generator = HashGenerator.new
generator.store(:hello, 'world!')
generator.to_h # => {:hello=>"world!"}
```

Or use `#new_object` and `#store_scope` to nest hashes:

```ruby
require 'hash_generator'

generator = HashGenerator.new
generator.new_object
generator.store(:hello, 'world!')
generator.store_scope(:object)
generator.to_h # => {:object=>{:hello=>"world!"}}
```

Or use `#new_array` and `#push_scope` to push objects into an array:

```ruby
require 'hash_generator'

generator = HashGenerator.new
generator.new_array
generator.new_object
generator.store(:hello, 'world!')
generator.push_scope
generator.store_scope(:array)
generator.to_h # => {:array=>[{:hello=>"world!"}]}
```

## Contributing

1. Fork it (https://github.com/IvyApp/hash\_generator/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
