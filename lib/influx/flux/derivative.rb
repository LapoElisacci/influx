# frozen_string_literal: true

# |> derivative(unit: 1m, nonNegative: true)

module Influx
  module Flux
    class Derivative
      def initialize(unit:, non_negative:)
        @unit = unit
        @non_negative = non_negative
      end

      def to_flux
        <<~FLUX.chomp
          |> derivative(unit: #{@unit}, nonNegative: #{@non_negative})
        FLUX
      end
    end
  end
end
