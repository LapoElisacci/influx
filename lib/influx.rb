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
    def from(bucket:)
      Influx::Query.new(bucket: bucket)
    end

    def now(precision = :nanosecond)
      Process.clock_gettime(Process::CLOCK_REALTIME, precision)
    end
  end
end
