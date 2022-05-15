# frozen_string_literal: true

# |> histogram(
#   column: "_value",
#   upperBoundColumn: "le",
#   countColumn: "_value",
#   bins: [100.0, 200.0, 300.0, 400.0],
# )

module Influx
  module Flux
    class Histogram
      def initialize(column:, upper_bound_column:, count_column:, bins: [])
        @column = column
        @upper_bound_column = upper_bound_column
        @count_column = count_column
        @bins = bins
      end

      def to_flux
        <<~FLUX.chomp
          |> histogram(column: "#{@column}", upperBoundColumn: "#{@upper_bound_column}", countColumn: "#{@count_column}", bins: #{@bins.to_json})
        FLUX
      end
    end
  end
end
