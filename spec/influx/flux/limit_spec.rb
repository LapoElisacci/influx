# frozen_string_literal: true

RSpec.describe Influx::Flux::Limit do
  it 'Creates a flux limit' do
    limit = described_class.new(n: 10)
    expect(limit.to_flux).to eq('|> limit(n: 10)')
  end
end
