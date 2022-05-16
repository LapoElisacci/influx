# frozen_string_literal: true

# |> limit(n: 4)

module Influx
  module Flux
    class Limit
      def initialize(n:)
        raise Influx::Error.new('Limit value has to be Integer!') unless n.is_a?(Integer)

        @n = n
      end

      def to_flux
        <<~FLUX.chomp
          |> limit(n: #{@n})
        FLUX
      end
    end
  end
end
