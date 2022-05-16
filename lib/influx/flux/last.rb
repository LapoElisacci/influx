# frozen_string_literal: true

# |> last()

module Influx
  module Flux
    class Last
      def self.to_flux
        <<~FLUX.chomp
          |> last()
        FLUX
      end
    end
  end
end
