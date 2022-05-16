# frozen_string_literal: true

RSpec.describe Influx::Flux::Median do
  it 'Creates a flux median' do
    expect(described_class.to_flux).to eq('|> median()')
  end
end
