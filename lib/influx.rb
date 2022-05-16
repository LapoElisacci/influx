# frozen_string_literal: true

require 'influxdb-client'

require_relative 'influx/configuration'
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
    attr_accessor :config, :client, :query

    PRECISION_MAP = {
      "s": :second,
      "ms": :millisecond,
      "us": :microsecond,
      "ns": :nanosecond,
    }

    def configure
      self.config = Influx::Configuration.new
      yield(config)
      self.client = InfluxDB2::Client.new(
        config.host,
        config.token,
        bucket: config.bucket,
        org: config.org,
        precision: config.precision || InfluxDB2::WritePrecision::NANOSECOND,
        open_timeout: config.open_timeout || 10,
        write_timeout: config.write_timeout || 10,
        read_timeout: config.read_timeout || 10,
        max_redirect_count: config.max_redirect_count || 10,
        redirect_forward_authorization: config.redirect_forward_authorization || false,
        use_ssl: config.use_ssl,
        verify_mode: config.verify_mode || OpenSSL::SSL::VERIFY_NONE
      )

      true
    end

    def from(bucket:)
      Influx::Query.new(bucket: bucket)
    end

    def now
      Process.clock_gettime(Process::CLOCK_REALTIME, PRECISION_MAP[client.options[:precision].to_sym])
    end

    def query_api
      @@query_api ||= client.create_query_api
    end

    def write_api
      @@write_api ||= client.create_write_api
    end
  end
end
