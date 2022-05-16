# frozen_string_literal: true

# |> first()

module Influx
  module Flux
    class First
      def self.to_flux
        <<~FLUX.chomp
          |> first()
        FLUX
      end
    end
  end
end
