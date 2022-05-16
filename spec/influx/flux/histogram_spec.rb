# frozen_string_literal: true

RSpec.describe Influx::Flux::Histogram do
  it 'Creates a flux histogram' do
    histogram = described_class.new(column: '_value', upper_bound_column: 'le', count_column: '_value', bins: [100.0, 200.0, 300.0, 400.0])
    expect(histogram.to_flux).to eq('|> histogram(column: "_value", upperBoundColumn: "le", countColumn: "_value", bins: [100.0,200.0,300.0,400.0])')
  end
end
