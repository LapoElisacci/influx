# frozen_string_literal: true

RSpec.describe Influx::Flux::Derivative do
  it 'Creates a flux derivative' do
    derivative = described_class.new(unit: '1m', non_negative: true)
    expect(derivative.to_flux).to eq('|> derivative(unit: 1m, nonNegative: true)')
  end
end
