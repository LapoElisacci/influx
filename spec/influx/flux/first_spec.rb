# frozen_string_literal: true

RSpec.describe Influx::Flux::First do
  it 'Creates a flux first' do
    expect(described_class.to_flux).to eq('|> first()')
  end
end
