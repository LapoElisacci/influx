# frozen_string_literal: true

RSpec.describe Influx::Flux::Last do
  it 'Creates a flux last' do
    expect(described_class.to_flux).to eq('|> last()')
  end
end
