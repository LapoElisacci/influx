# frozen_string_literal: true

RSpec.describe Influx::Flux::Group do
  it 'Creates a flux group' do
    group = described_class.new(columns: ['host'], mode: 'by')
    expect(group.to_flux).to eq('|> group(columns: ["host"], mode: "by")')
  end
end
