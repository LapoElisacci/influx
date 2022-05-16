# frozen_string_literal: true

RSpec.describe Influx::Flux::MovingAverage do
  it 'Creates a flux moving average' do
    moving_average = described_class.new(n: 10)
    expect(moving_average.to_flux).to eq('|> movingAverage(n: 10)')
  end
end
