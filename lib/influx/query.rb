# frozen_string_literal: true

module Influx
  class Query
    def initialize(bucket:)
      @bucket = bucket
      @range = {}
      @filters = []
      @group = {}
      @sort = {}
      @limit = {}
      @aggregate_window = {}

      @flux = "from(bucket: '#{bucket}')"
    end

    def range(**range_hash)
      @range = range_hash.compact

      self
    end
  end
end
