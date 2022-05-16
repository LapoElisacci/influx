# frozen_string_literal: true

RSpec.describe Influx::Flux::Fill do
  context 'with use_previous: true' do
    it 'Creates a flux fill with usePrevious: true' do
      fill = described_class.new(use_previous: true)

      expect(fill.to_flux).to eq('|> fill(usePrevious: true)')
    end
  end

  context 'with value: 0.0' do
    it 'Creates a flux fill with value: 0.0' do
      fill = described_class.new(value: 0.0)

      expect(fill.to_flux).to eq('|> fill(value: 0.0)')
    end
  end
end
