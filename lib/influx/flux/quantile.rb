# frozen_string_literal: true

# |> quantile(q: 0.99, method: "estimate_tdigest")

module Influx
  module Flux
    class Quantile
      def initialize(q:, method:)
        @q = q
        @method = method
      end

      def to_flux
        <<~FLUX.chomp
          |> quantile(q: #{@q}, method: "#{@method}")
        FLUX
      end
    end
  end
end
