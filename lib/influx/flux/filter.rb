# frozen_string_literal: true

# |> filter(fn: (r) => r._measurement == "example-measurement" and r._field == "example-field")

module Influx
  module Flux
    class Filter
      def initialize(**params)
        @params = params
      end

      def to_flux
        <<~FLUX.chomp
          |> filter(fn: (r) => #{@params.map { |k, v| "r.#{k} == #{v.to_json}" }.join(' and ')})
        FLUX
      end
    end
  end
end
