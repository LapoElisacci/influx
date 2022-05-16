# frozen_string_literal: true

RSpec.describe Influx::Flux::AggregateWindow do
  it 'Creates a flux aggregate window' do
    aggregate_window = described_class.new(every: '20m', fn: 'mean')

    expect(aggregate_window.to_flux).to eq('|> aggregateWindow(every: 20m, fn: mean)')
  end
end
