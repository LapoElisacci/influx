# frozen_string_literal: true

RSpec.describe Influx do
  it 'Has a version number' do
    expect(Influx::VERSION).not_to be nil
  end

  it 'Allows to start a flux query with from' do
    query = described_class.from(bucket: 'my-bucket')
    expect(query.class).to eq(Influx::Query)
    expect(query.to_flux).to eq('from(bucket: "my-bucket") ')
  end
end
