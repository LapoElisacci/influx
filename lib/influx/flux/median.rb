# frozen_string_literal: true

# |> median()

module Influx
  module Flux
    class Median
      def to_flux
        <<~FLUX.chomp
          |> median()
        FLUX
      end
    end
  end
end
