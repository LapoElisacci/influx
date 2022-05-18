# frozen_string_literal: true

require 'json'

require_relative 'influx/point'
require_relative 'influx/query'
require_relative 'influx/version'

require_relative 'influx/flux/aggregate_window'
require_relative 'influx/flux/cumulative_sum'
require_relative 'influx/flux/derivative'
require_relative 'influx/flux/fill'
require_relative 'influx/flux/filter'
require_relative 'influx/flux/first'
require_relative 'influx/flux/from'
require_relative 'influx/flux/group'
require_relative 'influx/flux/histogram'
require_relative 'influx/flux/increase'
require_relative 'influx/flux/last'
require_relative 'influx/flux/limit'
require_relative 'influx/flux/median'
require_relative 'influx/flux/moving_average'
require_relative 'influx/flux/quantile'
require_relative 'influx/flux/range'
require_relative 'influx/flux/sort'
require_relative 'influx/flux/timed_moving_average'

module Influx
  class Error < StandardError; end

  class << self
    #
    # Instantiate a new Influx::Query object with from clause.
    #
    # @param [String] bucket InfluxDB bucket nameß
    #
    # @return [Influx::Query] InfluxDB query object
    #
    def from(bucket:)
      Influx::Query.new(bucket: bucket)
    end

    #
    # Returns the current timestamp according to the passed precision.
    #
    # @param [Symbol] precision Timestamp precision
    #
    # @return [Integer] Current timestamp
    #
    def now(precision = :nanosecond)
      Process.clock_gettime(Process::CLOCK_REALTIME, precision)
    end
  end
end
