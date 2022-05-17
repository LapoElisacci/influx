## <img src="https://user-images.githubusercontent.com/50866745/168482997-7ed6ae74-aac9-4aee-bf03-fef5e01d683a.png" width="48" align="left"> Ruby InfluxDB Flux  <!-- omit in toc -->
[![CircleCI](https://circleci.com/gh/LapoElisacci/influx/tree/main.svg?style=svg)](https://circleci.com/gh/LapoElisacci/influx/tree/main)
![](https://img.shields.io/static/v1?label=Coverage&message=99.54%&color=brightgreen)
![](https://img.shields.io/static/v1?label=Latest&message=0.1.0.alpha&color=blue)
![](https://ruby-gem-downloads-badge.herokuapp.com/influx?type=total&color=blue)
![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)

Write InfluxDB Flux queries in an ORM fashion with Ruby.

## Table of contents

- [Table of contents](#table-of-contents)
- [Installation](#installation)
- [Utilities](#utilities)
  - [Now](#now)
- [Flux points](#flux-points)
- [Flux queries](#flux-queries)
  - [From](#from)
  - [Range](#range)
- [Query data with Flux](#query-data-with-flux)
  - [From](#from-1)
  - [Range](#range-1)
  - [Query fields and tags](#query-fields-and-tags)
  - [Group](#group)
  - [Sort and limit](#sort-and-limit)
  - [Window & aggregate](#window--aggregate)
  - [Increase](#increase)
  - [Moving Average](#moving-average)
  - [Rate](#rate)
  - [Histograms](#histograms)
  - [Fill](#fill)
  - [Median](#median)
  - [Percentile & quantile](#percentile--quantile)
  - [Join (TBD)](#join-tbd)
  - [Cumulative sum](#cumulative-sum)
  - [First & last](#first--last)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add influx

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install influx

## Utilities

Here are some utility methods provided by the gem.

### Now

The gem provides a method to return the Clock timestamp in nanoseconds.

```Ruby
Influx.now # Default precision is Nanoseconds
```

You can also pass other precisions if needed:

```Ruby
Influx.now(:second)
Influx.now(:millisecond)
Influx.now(:microsecond)
Influx.now(:nanosecond)
```

---

## Flux points

```Ruby
Influx::Point.new(
  'h2o', # measurement
  tags: { location: 'west' },
  fields: { value: 33 },
  time: Influx.now # The default value is Influx.now, you can also use Time or Integer
).to_flux # h2o,location=west value=33 1652720908000000
```

## Flux queries

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

---

## Query data with Flux

The following guides are based on top of the original InfluxData Flux Documentation, available [here](https://docs.influxdata.com/influxdb/cloud/query-data/flux/).

**Example data variable**
Many of the examples provided in the following guides use a **data** variable, which represents a basic query that filters data by measurement and field. **data** is defined as:

```Ruby
data = Influx.from(bucket: 'my-bucket').range(start: '-1d', stop: 'now()')

# from(bucket: "my-bucket")
#   |> range(start: -1d, stop: now())
```

### From

The `from` method allows you to specify the InfluxDB bucket. Every query starts with the `from` method.

```Ruby
Influx.from(bucket: 'my-bucket')

# from(bucket: "my-bucket")
```

### Range

The `range` method allows you to bind your query to a time range, it supports native Flux syntax as well as the Ruby `Time` class and `Integer`.

```Ruby
Influx.from(bucket: 'my-bucket').range(start: '-1d', stop: 'now()')

# from(bucket: "my-bucket")
#   |> range(start: -1d, stop: now())
```
```Ruby
Influx.from(bucket: 'my-bucket').range(start: Time.new(2018, 1, 1, 0, 0, 0, '+00:00').utc, stop: 1514768400)

# from(bucket: "my-bucket")
#   |> range(start: 2018-01-01T00:00:00Z, stop: 2018-01-01T01:00:00Z)
```

---

### Query fields and tags

Use `filter()` to query data based on fields, tags, or any other column value.

```Ruby
data.filter("_measurement": "example-measurement", tag: "example-tag")

# data
#   |> filter(fn: (r) => r._measurement == "example-measurement" and r.tag == "example-tag")
```

### Group

Use `group()` to group data with common values in specific columns.

```Ruby
data.group(columns: ["host"], mode: "by")

# data
#   |> group(columns: ["host"], mode: "by")
```

### Sort and limit

Use `sort()` to order records within each table by specific columns and `limit()` to limit the number of records in output tables to a fixed number, `n`.

```Ruby
data.sort(columns: ["host", "_value"]).limit(4)

# data
#   |> sort(columns: ["host","_value"])
#   |> limit(n: 4)
```

### Window & aggregate

```Ruby
data.aggregate_window(every: "20m", fn: "mean")

# data
#   |> aggregateWindow(every: 20m, fn: mean)
```

### Increase

Use `increase()` to track increases across multiple columns in a table. 

```Ruby
data.increase

# data
#   |> increase()
```

### Moving Average

Use `moving_average()` or `timed_moving_average()` to return the moving average of data.

```Ruby
data.moving_average(5)

# data
#   |> movingAverage(n: 5)
```
```Ruby
data.timed_moving_average(every: "2m", period: "4m")

# data
#   |> timedMovingAverage(every: 2m, period: 4m)
```

### Rate

Use `derivative()` to calculate the rate of change between subsequent values.

```Ruby
data.derivative(unit: "1m", non_negative: true)

# data
#   |> derivative(unit: 1m, nonNegative: true)
```

### Histograms

Use `histogram()` to create cumulative histograms with Flux.

```Ruby
data.histogram(column: "_value", upper_bound_column: "le", count_column: "_value", bins: [100.0, 200.0, 300.0, 400.0])

# data
#   |> histogram(
#     column: "_value",
#     upperBoundColumn: "le",
#     countColumn: "_value",
#     bins: [100.0,200.0,300.0,400.0]
#   )
```
### Fill

Use `fill()` function to replace null values.

```Ruby
data.fill(use_previous: true)

# data
#   |> fill(usePrevious: true)
```
```Ruby
data.fill(value: 0.0)
# data
#   |> fill(value: 0.0)
```

### Median

Use `median()` to return a value representing the 0.5 quantile (50th percentile) or median of input data.

```Ruby
data.median

# data
#   |> median()
```

### Percentile & quantile

Use the `quantile()` function to return all values within the `q` quantile or percentile of input data.

```Ruby
data.quantile(q: 0.99, method: "estimate_tdigest")

# data
#   |> quantile(q: 0.99, method: "estimate_tdigest")
```


### Join (TBD)

TBD

### Cumulative sum

Use the `cumulativeSum()` function to calculate a running total of values.

```Ruby
data.cumulative_sum

# data
#   |> cumulativeSum()
```

### First & last

Use `first()` or `last()`  to return the first or last point in an input table.

```Ruby
data.first

# data
#   |> first()
```
```Ruby
data.last

# data
#   |> last()
```

---

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/influx. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/influx/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Influx project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/influx/blob/master/CODE_OF_CONDUCT.md).
