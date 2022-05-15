# frozen_string_literal: true

# |> cumulativeSum()

module Influx
  module Flux
    class CumulativeSum
      def to_flux
        <<~FLUX.chomp
          |> cumulativeSum()
        FLUX
      end
    end
  end
end
