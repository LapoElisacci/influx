# frozen_string_literal: true

# |> movingAverage(n: 5)

module Influx
  module Flux
    class MovingAverage
      def initialize(n:)
        raise Influx::Error.new('N value has to be Integer!') unless n.is_a?(Integer)

        @n = n
      end

      def to_flux
        <<~FLUX.chomp
          |> movingAverage(n: #{@n})
        FLUX
      end
    end
  end
end
