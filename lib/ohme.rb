# frozen_string_literal: true

require_relative 'ohme/version'
require_relative 'ohme/configuration'
require_relative 'ohme/client'
require_relative 'ohme/api/contact'
require_relative 'ohme/api/payment'

# Ohme API client gem main module.
module Ohme
  class Error < StandardError; end
  # Your code goes here...
end
