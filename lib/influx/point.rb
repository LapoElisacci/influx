# frozen_string_literal: true

module Influx
  class Point
    def initialize(measurement, tags: {}, fields: {}, time: Influx.now)
      @measurement = measurement
      @tags = tags
      @fields = fields
      @time = time.to_i
    end

    def save(bucket: nil, org: nil, precision: InfluxDB2::WritePrecision::NANOSECOND)
      Influx.write_api.write(bucket: bucket || Influx.config.bucket, data: to_flux, org: org || Influx.config.org, precision: precision)
    end

    def to_flux
      "#{@measurement},#{hash_to_flux(@tags)} #{hash_to_flux(@fields)} #{@time}"
    end

    private

      def hash_to_flux(hash)
        hash.map { |key, value| "#{key}=#{value}" }.join(',')
      end
  end
end