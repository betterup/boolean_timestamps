# BooleanTimestamps

> Use boolean API's on your model, and persist the boolean as a timestamp when
it was changed

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'boolean_timestamps'
```

## Usage

```ruby
class Post < ActiveRecord::Base
  # assume published_at is in the schema
  boolean_timestamps :published_at
end
```

## Example

```ruby
# use the boolean attribute to auto-update the timestamp attribute
post = Post.create!(published: true)
puts post.published_at
#=> 2015-10-17 08:27

# clear the timestamp with by setting the boolean to false
post.update!(published: false)
puts post.published_at
#=> nil
```

This also adds a scope for each timestamps column

```ruby
Post.published
#=> [#<Post published_at: Fri, 04 Sep 2020 18:16:38 UTC +00:00>]

Post.published(false)
#=> [#<Post published_at: nil>]
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/betterup/boolean_timestamps.

