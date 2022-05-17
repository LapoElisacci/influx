# frozen_string_literal: true

RSpec.describe Influx::Query do
  it 'Creates a flux query' do
    query = described_class.new(bucket: 'my-bucket')
    expect(query.to_flux).to eq('from(bucket: "my-bucket") ')
  end

  context 'aggregate_window' do
    it 'Adds an aggregate window statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.aggregate_window(every: '10s', fn: 'mean')
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> aggregateWindow(every: 10s, fn: mean)')
    end
  end

  context 'cumulative_sum' do
    it 'Adds a cumulative sum statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.cumulative_sum
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> cumulativeSum()')
    end
  end

  context 'derivative' do
    it 'Adds a derivative statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.derivative(unit: '1s', non_negative: true)
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> derivative(unit: 1s, nonNegative: true)')
    end
  end

  context 'fill' do
    it 'Adds a fill statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.fill(use_previous: true)
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> fill(usePrevious: true)')
    end
  end

  context 'filter' do
    it 'Adds a filter statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.filter(fn: 'mean', value: 0)
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> filter(fn: (r) => r.fn == "mean" and r.value == 0)')
    end
  end

  context 'first' do
    it 'Adds a first statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.first
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> first()')
    end
  end

  context 'group' do
    it 'Adds a group statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.group(columns: ['fn'], mode: 'by')
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> group(columns: ["fn"], mode: "by")')
    end
  end

  context 'histogram' do
    it 'Adds a histogram statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.histogram(column: 'fn', upper_bound_column: 'upper_bound', count_column: 'count', bins: [0, 1, 2])
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> histogram(column: "fn", upperBoundColumn: "upper_bound", countColumn: "count", bins: [0,1,2])')
    end
  end

  context 'increase' do
    it 'Adds an increase statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.increase
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> increase()')
    end
  end

  context 'last' do
    it 'Adds a last statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.last
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> last()')
    end
  end

  context 'limit' do
    it 'Adds a limit statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.limit(10)
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> limit(n: 10)')
    end
  end

  context 'median' do
    it 'Adds a median statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.median
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> median()')
    end
  end

  context 'moving_average' do
    it 'Adds a moving average statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.moving_average(10)
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> movingAverage(n: 10)')
    end
  end

  context 'quantile' do
    it 'Adds a quantile statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.quantile(q: 0.5, method: 'linear')
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> quantile(q: 0.5, method: "linear")')
    end
  end

  context 'range' do
    it 'Adds a range statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.range(start: '-1d', stop: 'now')
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> range(start: -1d, stop: now)')
    end
  end

  context 'sort' do
    it 'Adds a sort statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.sort(columns: ['fn'])
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> sort(columns: ["fn"])')
    end
  end

  context 'timed_moving_average' do
    it 'Adds a timed moving average statement' do
      query = described_class.new(bucket: 'my-bucket')
      query.timed_moving_average(every: '10s', period: '1h')
      expect(query.to_flux).to eq('from(bucket: "my-bucket") |> timedMovingAverage(every: 10s, period: 1h)')
    end
  end
end
