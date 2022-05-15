# frozen_string_literal: true

require_relative 'influx/configuration'
require_relative 'influx/version'

require_relative 'influx/query'
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

    def configure
      self.query = Influx::Query.new
      self.config = Influx::Configuration.new
      yield(config)
      self.client = InfluxDB2::Client.new(
        config.host,
        config.token,
        bucket: config.bucket,
        org: config.org,
        precision: config.precision,
        open_timeout: config.open_timeout || 10,
        write_timeout: config.write_timeout || 10,
        read_timeout: config.read_timeout || 10,
        max_redirect_count: config.max_redirect_count || 10,
        redirect_forward_authorization: config.redirect_forward_authorization || false,
        use_ssl: config.use_ssl || true,
        verify_mode: config.verify_mode
      )
    end

    def from(bucket:)
      Influx::Query.new.from(bucket: bucket)
    end
  end
end
