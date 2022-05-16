# frozen_string_literal: true

# |> sort(columns: ["host", "_value"])

module Influx
  module Flux
    class Sort
      def initialize(columns:)
        raise Influx::Error.new('Columns value has to be Array of Strings!') unless columns.is_a?(Array) && columns.all? { |c| c.is_a?(String) }

        @columns = columns
      end

      def to_flux
        <<~FLUX.chomp
          |> sort(columns: #{@columns.to_json})
        FLUX
      end
    end
  end
end
