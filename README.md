# ActiveRecord::PostgreAnalyzer

[![Gem Version](https://badge.fury.io/rb/active_record-postgre_analyzer.svg)](https://badge.fury.io/rb/active_record-postgre_analyzer)

Analyze the execution plan and write log if sequential scan is detected.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record-postgre_analyzer', group: :development
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record-postgre_analyzer

## Usage

Output to a logfile if sequential scan is detected.

```console
------------ find Seq Scan query ------------
SELECT  "todo".* FROM "todo" WHERE "todo"."user_id" = $1 LIMIT 1
                                         QUERY PLAN
---------------------------------------------------------------------------------------------
 Limit  (cost=10000000000.00..10000000001.67 rows=1 width=81)
   ->  Seq Scan on todo  (cost=10000000000.00..10000000001.67 rows=1 width=81)
         Filter: (user_id = 13)
(3 rows)

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/m3dev/active_record-postgre_analyzer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

