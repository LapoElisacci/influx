# frozen_string_literal: true

# |> increase()

module Influx
  module Flux
    class Increase
      def self.to_flux
        <<~FLUX.chomp
          |> increase()
        FLUX
      end
    end
  end
end
