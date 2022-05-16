# <img src="https://user-images.githubusercontent.com/50866745/168482997-7ed6ae74-aac9-4aee-bf03-fef5e01d683a.png" width="48"> InfluxDB Flux ORM  <!-- omit in toc -->

<!-- [![CircleCI](https://circleci.com/gh/LapoElisacci/Ksql/tree/main.svg?style=svg)](https://circleci.com/gh/LapoElisacci/Ksql/tree/main)
![](https://img.shields.io/static/v1?label=Coverage&message=98.78%&color=brightgreen) -->
![](https://img.shields.io/static/v1?label=Latest&message=0.1.0.alpha&color=blue)
![](https://ruby-gem-downloads-badge.herokuapp.com/influx?type=total&color=blue)
![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)

- [Installation](#installation)
- [Usage](#usage)
  - [Configuration](#configuration)
- [Queries](#queries)
  - [From](#from)
  - [Range](#range)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add influx

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install influx

## Usage

The gem allows you to perform Flux queries to InfluxDB in an ORM fashion

```Ruby
results = Influx.from(bucket: 'my-bucket').range(start: '-1d', stop: 'now()').query
```

### Configuration

> If you're including the gem under a Rails application you can run `rails generate influx`.

```Ruby
Influx.configure do |config|
  config.host = 'https://localhost:8086'
  config.token = 'InfluxDB2-Token'
  config.precision = InfluxDB2::WritePrecision::NANOSECOND
  config.use_ssl = true
end
```

**Options**

| Option | Description | Type | Default |
|---|---|---|---|
| bucket | Default destination bucket for writes | String | none |
| org | Default organization bucket for writes | String | none |
| precision | Default precision for the unix timestamps within the body line-protocol | `InfluxDB2::WritePrecision::SECOND` or `InfluxDB2::WritePrecision::MILLISECOND` or `InfluxDB2::WritePrecision::MICROSECOND` or `InfluxDB2::WritePrecision::NANOSECOND` | none |
| open_timeout | Number of seconds to wait for the connection to open | Integer | 10 |
| write_timeout | Number of seconds to wait for one block of data to be written | Integer | 10 |
| read_timeout | Number of seconds to wait for one block of data to be read | Integer | 10 |
| max_redirect_count | Maximal number of followed HTTP redirects | Integer | 10 |
| redirect_forward_authorization | Pass Authorization header to different domain during HTTP redirect. | bool | false |
| use_ssl | Turn on/off SSL for HTTP communication | bool | true |
| verify_mode | Sets the flags for the certification verification at beginning of SSL/TLS session. | `OpenSSL::SSL::VERIFY_NONE` or `OpenSSL::SSL::VERIFY_PEER` | none |

## Queries

The gem acts as an ORM therefore you can chain methods to build your `Flux` query string.

You can always call the `to_flux` method to see a preview or your query:

```Ruby
flux_query = Influx.from(bucket: 'my-bucket').range(start: '-1d')
flux_query.to_flux # from(bucket: "my-bucket") |> range(start: -1d)
```

### From

The `from` method is the starting point of all queries, it allows you to specify the InfluxDB bucket.

```Ruby
Influx.from(bucket: 'my-bucket')
```
> ⚠️ This is mandatory to perform any query.

### Range

The `range` method allows you to specify the time-range you want to query.

```Ruby
Influx.from(bucket: 'my-bucket').range(start: '-1d', stop: 'now()')
```

It supports the `Flux` sytanx as well as `Time`.

```Ruby
Influx.from(bucket: 'my-bucket').range(start: Time.new.yesterday, stop: Time.new)
```

> ⚠️ This is mandatory to perform any query.



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/influx. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/influx/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Influx project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/influx/blob/master/CODE_OF_CONDUCT.md).
