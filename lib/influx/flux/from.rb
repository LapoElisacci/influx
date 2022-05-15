# frozen_string_literal: true

module Influx
  module Flux
    class From
      attr_accessor :bucket

      def initialize(bucket:)
        @bucket = bucket
      end

      def to_flux
        <<~FLUX.chomp
          from(bucket: "#{@bucket}")
        FLUX
      end
    end
  end
end
