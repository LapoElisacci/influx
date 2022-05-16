# frozen_string_literal: true

RSpec.describe Influx do
  it 'Has a version number' do
    expect(Influx::VERSION).not_to be nil
  end

  it 'Allows to configure the connection' do # rubocop:disable Metrics/BlockLength
    res = described_class.configure do |config|
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
    end

    expect(res).to eq(true)
    expect(described_class.config.class).to eq(Influx::Configuration)
    expect(described_class.config.host).to eq('http://localhost:8086')
    expect(described_class.config.token).to eq('InfluxToken')
    expect(described_class.config.bucket).to eq('my-bucket')
    expect(described_class.config.org).to eq('my-org')
    expect(described_class.config.precision).to eq(InfluxDB2::WritePrecision::NANOSECOND)
    expect(described_class.config.open_timeout).to eq(10)
    expect(described_class.config.write_timeout).to eq(10)
    expect(described_class.config.read_timeout).to eq(10)
    expect(described_class.config.max_redirect_count).to eq(10)
    expect(described_class.config.redirect_forward_authorization).to eq(false)
    expect(described_class.config.use_ssl).to eq(true)
    expect(described_class.config.verify_mode).to eq(OpenSSL::SSL::VERIFY_NONE)

    expect(described_class.client.class).to eq(InfluxDB2::Client)
  end

  it 'Allows to start a flux query with from' do
    query = described_class.from(bucket: 'my-bucket')
    expect(query.class).to eq(Influx::Query)
    expect(query.to_flux).to eq('from(bucket: "my-bucket") ')
  end

  it 'Allows to get current time according to configured precision' do
    allow(Influx.client).to receive(:options).and_return({ precision: 's' })
    expect(Influx.now.to_s.length).to eq(10)
    allow(Influx.client).to receive(:options).and_return({ precision: 'ms' })
    expect(Influx.now.to_s.length).to eq(13)
    allow(Influx.client).to receive(:options).and_return({ precision: 'us' })
    expect(Influx.now.to_s.length).to eq(16)
    allow(Influx.client).to receive(:options).and_return({ precision: 'ns' })
    expect(Influx.now.to_s.length).to eq(19)
  end
end
