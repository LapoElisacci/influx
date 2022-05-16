# frozen_string_literal: true

RSpec.describe Influx::Flux::Range do
  context 'When only a start value is given' do
    it 'Creates a flux range with start: -1m' do
      range = described_class.new(start: '-1m')
      expect(range.to_flux).to eq('|> range(start: -1m)')
    end
  end

  context 'When only a stop value is given' do
    it 'Creates a flux range with stop: -1m' do
      range = described_class.new(stop: '-1m')
      expect(range.to_flux).to eq('|> range(stop: -1m)')
    end
  end

  context 'When both a start and a stop value are given' do
    it 'Creates a flux range with start: -1h and stop: -1m' do
      range = described_class.new(start: '-1h', stop: '-1m')
      expect(range.to_flux).to eq('|> range(start: -1h, stop: -1m)')
    end
  end
end
