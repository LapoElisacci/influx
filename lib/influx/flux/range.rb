# frozen_string_literal: true

# |> range(start: -1h)

module Influx
  module Flux
    class Range
      attr_accessor :start, :stop

      def initialize(start: nil, stop: nil)
        @start = start.is_a?(Time) ? start.iso8601 : start
        @stop = stop.is_a?(Time) ? stop.iso8601 : stop
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
