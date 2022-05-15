# frozen_string_literal: true

# |> fill(usePrevious: true)
# |> fill(value: 0.0)

module Influx
  module Flux
    class Fill
      def initialize(use_previous:, value:)
        @use_previous = use_previous
        @value = value
      end

      def to_flux
        if @use_previous
          <<~FLUX.chomp
            |> fill(usePrevious: #{@use_previous})
          FLUX
        else
          <<~FLUX.chomp
            |> fill(value: #{@value})
          FLUX
        end
      end
    end
  end
end
