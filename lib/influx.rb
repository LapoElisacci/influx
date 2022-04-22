# frozen_string_literal: true

require_relative 'influx/base'
require_relative 'influx/configuration'
require_relative 'influx/version'

module Influx
  class Error < StandardError; end

  class << self
    attr_accessor :config

    def configure
      self.config = Influx::Configuration.new
      yield(config)
    end
  end
end
