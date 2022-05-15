# frozen_string_literal: true

# |> last()

module Influx
  module Flux
    class Last
      def to_flux
        <<~FLUX.chomp
          |> last()
        FLUX
      end
    end
  end
end
