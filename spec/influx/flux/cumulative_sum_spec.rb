# frozen_string_literal: true

RSpec.describe Influx::Flux::CumulativeSum do
  it 'Creates a flux cumulative sum' do
    expect(described_class.to_flux).to eq('|> cumulativeSum()')
  end
end
