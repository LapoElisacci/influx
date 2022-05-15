# frozen_string_literal: true

require_relative 'influx'

Influx.configure do |config|
  config.host = 'https://localhost:8086'
  config.token = 'InfluxDB2-Token'
end
