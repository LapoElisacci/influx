# frozen_string_literal: true

RSpec.describe Influx::Flux::Filter do
  it 'Creates a flux filter' do
    filter = described_class.new("_measurement": 'my_measurement')
    expect(filter.to_flux).to eq('|> filter(fn: (r) => r._measurement == "my_measurement")')
  end
end
