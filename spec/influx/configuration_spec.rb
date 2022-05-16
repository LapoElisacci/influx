# frozen_string_literal: true

RSpec.describe Influx::Configuration do
  it 'Saves the configuration' do
    config = Influx::Configuration.new
    config.host = 'http://localhost:8086'
    config.token = 'InfluxToken'
    config.bucket = 'my-bucket'
    config.org = 'my-org'
    config.precision = InfluxDB2::WritePrecision::NANOSECOND
    config.open_timeout = 10
    config.write_timeout = 10
    config.read_timeout = 10
    config.max_redirect_count = 10
    config.redirect_forward_authorization = false
    config.use_ssl = true
    config.verify_mode = OpenSSL::SSL::VERIFY_NONE

    expect(config.host).to eq('http://localhost:8086')
    expect(config.token).to eq('InfluxToken')
    expect(config.bucket).to eq('my-bucket')
    expect(config.org).to eq('my-org')
    expect(config.precision).to eq(InfluxDB2::WritePrecision::NANOSECOND)
    expect(config.open_timeout).to eq(10)
    expect(config.write_timeout).to eq(10)
    expect(config.read_timeout).to eq(10)
    expect(config.max_redirect_count).to eq(10)
    expect(config.redirect_forward_authorization).to eq(false)
    expect(config.use_ssl).to eq(true)
    expect(config.verify_mode).to eq(OpenSSL::SSL::VERIFY_NONE)
  end
end
