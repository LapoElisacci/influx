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

  context 'When the value is not a Time, String or Integer' do
    it 'Raises an error' do
      expect { described_class.new(start: 1.2, stop: DateTime.new) }.to raise_error(ArgumentError, 'Invalid time format, expected Time, String or Integer')
    end
  end

  context 'When the value is a Time' do
    it 'Creates a flux range with start: 2018-01-01T00:00:00Z and stop: 2018-01-01T00:00:00Z' do
      range = described_class.new(start: Time.new(2018, 1, 1, 0, 0, 0, '+00:00').utc, stop: Time.new(2018, 1, 1, 0, 0, 0, '+00:00').utc)
      expect(range.to_flux).to eq('|> range(start: 2018-01-01T00:00:00Z, stop: 2018-01-01T00:00:00Z)')
    end
  end
end
