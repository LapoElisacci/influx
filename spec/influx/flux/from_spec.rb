# frozen_string_literal: true

RSpec.describe Influx::Flux::From do
  it 'Creates a flux from' do
    from = described_class.new(bucket: 'my-bucket')
    expect(from.to_flux).to eq('from(bucket: "my-bucket")')
  end
end
