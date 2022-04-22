# frozen_string_literal: true

require_relative 'influx'

Influx.configure do |config|
  config.client = InfluxDB2::Client.new('https://localhost:8086', 'my-token')
end
