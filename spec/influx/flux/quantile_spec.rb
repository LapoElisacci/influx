# frozen_string_literal: true

RSpec.describe Influx::Flux::Quantile do
  it 'Creates a flux quantile' do
    quantile = described_class.new(q: 0.99, method: 'estimate_tdigest')
    expect(quantile.to_flux).to eq('|> quantile(q: 0.99, method: "estimate_tdigest")')
  end
end
