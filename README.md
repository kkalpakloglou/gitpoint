# Gitpoint

Gitpoint is a simple command line app that displays usage statistics for organizations repos. Then main purpose of the gem is to fetch and analyze repository information, such as the programming languages used on the organization and the rate of usage, relative to each other.

## Installation


Install app from rubygems:

    $ gem install gitpoint

## Usage

Langstats

The initial feature, implemented on Gitpoint, is langstats. Langstats provides a list of programming languages used on a given organization's public repositories. Langstats provides, also, a relative percentage of usage per language for the organization. 

To extract the above information, pass the name of the organization, to --organization parameter, as below:

```ruby
gitpoint langstats --organization <organization_name>
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kkalpakloglou/gitpoint.
