# frozen_string_literal: true

# |> range(start: -1h)

module Influx
  module Flux
    class Range
      attr_accessor :start, :stop

      def initialize(start: nil, stop: nil)
        @start = start
        @stop = stop
      end

      def to_flux
        params = []

        params << "start: #{@start}" if @start
        params << "stop: #{@stop}" if @stop

        <<~FLUX.chomp
          |> range(#{params.join(', ')})
        FLUX
      end
    end
  end
end
