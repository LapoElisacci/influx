# frozen_string_literal: true

require_relative 'influx'

Influx.configure do |config|
  config.host = 'https://localhost:8086'
  config.token = 'InfluxDB2-Token'
  # config.bucket = 'my-bucket'
  # config.org = 'my-org'
  # config.precision = InfluxDB2::WritePrecision::NANOSECOND # or SECOND, MILLISECOND, MICROSECOND, NANOSECOND
  # config.open_timeout = 10
  # config.write_timeout = 10
  # config.read_timeout = 10
  # config.max_redirect_count = 10
  # config.redirect_forward_authorization = false
  # config.use_ssl = true
  # config.verify_mode = OpenSSL::SSL::VERIFY_NONE # or OpenSSL::SSL::VERIFY_PEER
end
