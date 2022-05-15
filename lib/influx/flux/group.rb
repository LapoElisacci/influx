# frozen_string_literal: true

# |> group(columns: ["host"], mode: "by")

module Influx
  module Flux
    class Group
      def initialize(columns: [], mode:)
        raise Influx::Error.new('Columns value has to be Array of Strings!') unless columns.is_a?(Array) && columns.all? { |c| c.is_a?(String) }

        @columns = columns
        @mode = mode
      end

      def to_flux
        <<~FLUX.chomp
          |> group(columns: #{@columns.to_json}, mode: "#{@mode}")
        FLUX
      end
    end
  end
end
