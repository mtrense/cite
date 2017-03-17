# Cite

Cite is a template engine that respects newlines and indentation even in nested templates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cite'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cite

## Getting Started

Compiling a template from a file:
```ruby
Cite.file(filename, options = {})
```
or compile a template from a string:
```ruby
Cite.inline(template_string, options = {})
```

Options may include
* `:stream_name`
* `:correct_indentation`

Rendering a compiled template:
```ruby
render([object = Object.new], [local_variables = {}])
```
where `object` is self in the context of the rendered template and `local_variables` may be a hash with keys made available as local variables within the template. Both arguments are optional


### Templates

* Cite can access local and instance variables on self as well as methods on self:
```ruby
A local variable: {{= name }}
An instance-variable: {{= @name }}
A method call: {{= concat(name, @name) }}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec cite` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

