# frozen_string_literal: true

module Influx
  class ConfigurationError < StandardError; end

  #
  # Influx configuration
  #
  class Configuration
    attr_accessor :host,
                  :token,
                  :bucket,
                  :org,
                  :precision,
                  :open_timeout,
                  :write_timeout,
                  :read_timeout,
                  :max_redirect_count,
                  :redirect_forward_authorization,
                  :use_ssl,
                  :verify_mode
  end
end
