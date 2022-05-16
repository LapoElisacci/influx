# frozen_string_literal: true

RSpec.describe Influx::Flux::Sort do
  it 'Creates a flux sort' do
    sort = described_class.new(columns: ['host', '_value'])
    expect(sort.to_flux).to eq('|> sort(columns: ["host","_value"])')
  end
end
