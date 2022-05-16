# frozen_string_literal: true

RSpec.describe Influx::Flux::TimedMovingAverage do
  it 'Creates a flux timed moving average' do
    timed_moving_average = described_class.new(every: '2m', period: '4m')
    expect(timed_moving_average.to_flux).to eq('|> timedMovingAverage(every: 2m, period: 4m)')
  end
end
