# frozen_string_literal: true

module Influx
  class ConfigurationError < StandardError; end

  #
  # Influx configuration
  #
  class Configuration
    attr_accessor :client

    def client(influxdb_client)
      raise Influx::ConfigurationError.new('The client must be an instance of InfluxDB2::Client!') unless influxdb_client.is_a? InfluxDB2::Client

      @client = influxdb_client
    end
  end
end
