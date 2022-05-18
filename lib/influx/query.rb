# frozen_string_literal: true

module Influx
  class Query
    def initialize(bucket:)
      @from = Influx::Flux::From.new(bucket: bucket)
      @statements = []
    end

    #
    # Attach an aggregateWindow statement to the query.
    #
    # @param [String] every The time interval to aggregate over.
    # @param [String] fn The function to apply to the aggregate window.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def aggregate_window(every:, fn:)
      @statements << Influx::Flux::AggregateWindow.new(every: every, fn: fn)
      self
    end

    #
    # Attach a cumulative sum statement to the query.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def cumulative_sum
      @statements << Influx::Flux::CumulativeSum
      self
    end

    #
    # Attach a derivative statement to the query.
    #
    # @param [String] unit The time unit to use for the derivative.
    # @param [Boolean] non_negative Whether to return non-negative values.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def derivative(unit:, non_negative: true)
      @statements << Influx::Flux::Derivative.new(unit: unit, non_negative: non_negative)
      self
    end

    #
    # Attach a fill statement to the query.
    #
    # @param [Boolean] use_previous Whether to use the previous value.
    # @param [Integer] value The value to use.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def fill(use_previous: false, value: nil)
      @statements << Influx::Flux::Fill.new(use_previous: use_previous, value: value)
      self
    end

    #
    # Attach a fill statement to the query.
    #
    # @param [Hash] **params The parameters to use for the query.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def filter(**params)
      @statements << Influx::Flux::Filter.new(**params)
      self
    end

    #
    # Attach a first statement to the query.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def first
      @statements << Influx::Flux::First
      self
    end

    #
    # Attach a group statement to the query.
    #
    # @param [Array<String>] columns The columns to group by.
    # @param [String] mode The mode to use for grouping.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def group(columns: [], mode:)
      @statements << Influx::Flux::Group.new(columns: columns, mode: mode)
      self
    end

    #
    # Attach a histogram statement to the query.
    #
    # @param [String] column The column to use for the histogram.
    # @param [String] upper_bound_column The column to use for the upper bound.
    # @param [String] count_column The column to use for the count.
    # @param [Array<Integer>] bins The bins to use for the histogram.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def histogram(column:, upper_bound_column:, count_column:, bins: [])
      @statements << Influx::Flux::Histogram.new(column: column, upper_bound_column: upper_bound_column, count_column: count_column, bins: bins)
      self
    end

    #
    # Attach an increase statement to the query.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def increase
      @statements << Influx::Flux::Increase
      self
    end

    #
    # Attach a last statement to the query.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def last
      @statements << Influx::Flux::Last
      self
    end

    #
    # Attach a limit statement to the query.
    #
    # @param [Integer] n The number of results to return.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def limit(n)
      @statements << Influx::Flux::Limit.new(n: n)
      self
    end

    #
    # Attach a median statement to the query.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def median
      @statements << Influx::Flux::Median
      self
    end

    #
    # Attach a moving average statement to the query.
    #
    # @param [Integer] n The number of values to average.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def moving_average(n)
      @statements << Influx::Flux::MovingAverage.new(n: n)
      self
    end

    #
    # Attach a quantile statement to the query.
    #
    # @param [Numeric] q The quantile to use.
    # @param [String] method The method to use for the quantile.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def quantile(q:, method:)
      @statements << Influx::Flux::Quantile.new(q: q, method: method)
      self
    end

    #
    # Attach a range statement to the query.
    #
    # @param [String/Time/Integer] start The start of the range.
    # @param [String/Time/Integer] stop The end of the range.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def range(start: nil, stop: nil)
      @statements << Influx::Flux::Range.new(start: start, stop: stop)
      self
    end

    #
    # Attach a sort statement to the query.
    #
    # @param [Array<String>] columns The columns to sort by.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def sort(columns:)
      @statements << Influx::Flux::Sort.new(columns: columns)
      self
    end

    #
    # Attach a timed moving average statement to the query.
    #
    # @param [String] every The time unit to use for the timed moving average.
    # @param [String] period The time unit to use for the period.
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def timed_moving_average(every:, period:)
      @statements << Influx::Flux::TimedMovingAverage.new(every: every, period: period)
      self
    end

    #
    # Build the query string.
    #
    # @return [String] Flux query string
    #
    def to_flux
      "#{@from.to_flux} #{@statements.map(&:to_flux).join(' ')}"
    end
  end
end
