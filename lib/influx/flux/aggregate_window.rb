# frozen_string_literal: true

# |> aggregateWindow(every: 20m, fn: mean)

module Influx
  module Flux
    class AggregateWindow
      def initialize(every:, fn:)
        @every = every
        @fn = fn
      end

      def to_flux
        <<~FLUX.chomp
          |> aggregateWindow(every: #{@every}, fn: #{@fn})
        FLUX
      end
    end
  end
end
