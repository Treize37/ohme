# frozen_string_literal: true

module Ohme
  # Configuration of the Ohme API client gem.
  class Configuration
    attr_accessor :base_url, :client_name, :client_secret, :timeout, :version

    # Initializes the configuration with default values.
    #
    # @yield [config] Optional block to configure the client
    # @return [Ohme::Configuration] A new instance of the configuration
    def initialize
      @base_url = "https://api-ohme.oneheart.fr/api/"
      @version = "v1"
      @timeout = 30
      yield self if block_given?
    end

    # Configures the Ohme API client with a block.
    #
    # @yield [config] A block to configure the client
    # @return [Ohme::Configuration] The current configuration instance
    def configure
      yield(self) if block_given?
    end

    # Validates the configuration values.
    #
    # @raise [RuntimeError] if required values are missing
    def validate!
      error_on("client_name") unless @client_name
      error_on("client_secret") unless @client_secret
    end

    private

    # Private: Raises an error if a required configuration attribute is missing.
    #
    # @param attribute [String] The name of the missing attribute
    # @raise [RuntimeError] if the attribute is missing
    def error_on(attribute)
      raise(
        "#{attribute} is missing. " \
          "Please configure Ohme::Configuration.#{attribute}."
      )
    end
  end
end
