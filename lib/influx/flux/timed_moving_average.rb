# frozen_string_literal: true

# |> timedMovingAverage(every: 2m, period: 4m)

module Influx
  module Flux
    class TimedMovingAverage
      def initialize(every:, period:)
        @every = every
        @period = period
      end

      def to_flux
        <<~FLUX.chomp
          |> timedMovingAverage(every: #{@every}, period: #{@period})
        FLUX
      end
    end
  end
end
