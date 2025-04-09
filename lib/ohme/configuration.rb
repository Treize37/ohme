# frozen_string_literal: true

module Ohme
  # Configuration of the Ohme API client gem.
  class Configuration
    attr_accessor :base_url, :client_name, :client_secret, :timeout, :version

    # Initializes the configuration with default values.
    def initialize
      @base_url = 'https://api-ohme.oneheart.fr/api/'
      @version = 'v1'
      @timeout = 30
      yield self if block_given?
    end

    def configure
      yield(self) if block_given?
    end

    # Validates the configuration values.
    def validate!
      error_on('client_name') unless @client_name
      error_on('client_secret') unless @client_secret
    end

    private

    def error_on(attribute)
      raise(
        "#{attribute} is missing. " \
          "Please configure Ohme::Configuration.#{attribute}."
      )
    end
  end
end
