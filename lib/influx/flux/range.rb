# frozen_string_literal: true

# |> range(start: -1h)

module Influx
  module Flux
    class Range
      attr_accessor :start, :stop

      def initialize(start: nil, stop: nil)
        @start = cast_value(start)
        @stop = cast_value(stop)
      end

      def to_flux
        params = []

        params << "start: #{@start}" if @start
        params << "stop: #{@stop}" if @stop

        <<~FLUX.chomp
          |> range(#{params.join(', ')})
        FLUX
      end

      private

        def cast_value(time)
          return if time.nil?

          case time.class.to_s
          when 'Time'
            time.iso8601
          when 'String'
            time
          when 'Integer'
            Time.at(time).iso8601
          else
            raise ArgumentError, 'Invalid time format, expected Time, String or Integer'
          end
        end
    end
  end
end
