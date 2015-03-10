# HashBuilder

Simple programmatic building of hashes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hash_builder'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install hash_builder
```

## Usage

Use `#store` to store primitive values:

```ruby
require 'hash_builder'

builder = HashBuilder.new
builder.store(:hello, 'world!')
builder.to_h # => {:hello=>"world!"}
```

Or use `#new_object` and `#store_scope` to nest hashes:

```ruby
require 'hash_builder'

builder = HashBuilder.new
builder.new_object
builder.store(:hello, 'world!')
builder.store_scope(:object)
builder.to_h # => {:object=>{:hello=>"world!"}}
```

Or use `#new_array` and `#push_scope` to push objects into an array:

```ruby
require 'hash_builder'

builder = HashBuilder.new
builder.new_array
builder.new_object
builder.store(:hello, 'world!')
builder.push_scope
builder.store_scope(:array)
builder.to_h # => {:array=>[{:hello=>"world!"}]}
```

## Contributing

1. Fork it (https://github.com/IvyApp/hash\_builder/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
