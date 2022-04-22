# frozen_string_literal: true

require 'rails/generators'

# Creates the Influx initializer file for Rails apps.
#
# @example Invocation from terminal
#   rails generate influx
#
class NotificationsUtilGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def generate_layout
    template 'initializer.rb', 'config/initializers/influx.rb'
  end
end
