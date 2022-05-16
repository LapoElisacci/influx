# frozen_string_literal: true

RSpec.describe Influx::Point do
  it 'Creates a flux record' do
    record = described_class.new('h2o', tags: { location: 'west' }, fields: { value: '33i' }, time: 1652692676652625000)
    expect(record.to_flux).to eq('h2o,location=west value=33i 1652692676652625000')
  end
end
