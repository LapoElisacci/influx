# frozen_string_literal: true

module Influx
  class Query
    def initialize(bucket:)
      @from = Influx::Flux::From.new(bucket: bucket)
      @statements = []
    end

    def query
      Influx.query_api.query(query: to_flux)
    end

    def query_stream(&block)
      Influx.query_api.query_streaming(query: to_flux) do |record|
        yield record
      end
    end

    def aggregate_window(every:, fn:)
      @statements << Influx::Flux::AggregateWindow.new(every: every, fn: fn)
      self
    end

    def cumulative_sum
      @statements << Influx::Flux::CumulativeSum
      self
    end

    def derivative(unit:, non_negative: true)
      @statements << Influx::Flux::Derivative.new(unit: unit, non_negative: non_negative)
      self
    end

    def fill(use_previous: false, value: nil)
      @statements << Influx::Flux::Fill.new(use_previous: use_previous, value: value)
      self
    end

    def filter(**params)
      @statements << Influx::Flux::Filter.new(**params)
      self
    end

    def first
      @statements << Influx::Flux::First
      self
    end

    def group(columns: [], mode:)
      @statements << Influx::Flux::Group.new(columns: columns, mode: mode)
      self
    end

    def histogram(column:, upper_bound_column:, count_column:, bins: [])
      @statements << Influx::Flux::Histogram.new(column: column, upper_bound_column: upper_bound_column, count_column: count_column, bins: bins)
      self
    end

    def increase
      @statements << Influx::Flux::Increase
      self
    end

    def last
      @statements << Influx::Flux::Last
      self
    end

    def limit(n)
      @statements << Influx::Flux::Limit.new(n: n)
      self
    end

    def median
      @statements << Influx::Flux::Median
      self
    end

    def moving_average(n)
      @statements << Influx::Flux::MovingAverage.new(n: n)
      self
    end

    def quantile(q:, method:)
      @statements << Influx::Flux::Quantile.new(q: q, method: method)
      self
    end

    def range(start: nil, stop: nil)
      @statements << Influx::Flux::Range.new(start: start, stop: stop)
      self
    end

    def sort(columns:)
      @statements << Influx::Flux::Sort.new(columns: columns)
      self
    end

    def timed_moving_average(every:, period:)
      @statements << Influx::Flux::TimedMovingAverage.new(every: every, period: period)
      self
    end

    def to_flux
      "#{@from.to_flux} #{@statements.map(&:to_flux).join(' ')}"
    end
  end
end
