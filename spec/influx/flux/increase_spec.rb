# frozen_string_literal: true

RSpec.describe Influx::Flux::Increase do
  it 'Creates a flux increase' do
    expect(described_class.to_flux).to eq('|> increase()')
  end
end
