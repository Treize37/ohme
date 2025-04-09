# frozen_string_literal: true

module Ohme
  # Configuration of the Ohme API client gem.
  module Configuration
    class << self
      attr_accessor :api_key, :base_url, :timeout, :domain, :version

      # Initializes the configuration with default values.
      def configure
        @base_url = 'https://api-ohme.oneheart.fr/api/' # Nouvelle URL de base
        @version = 'v1' # Version par défaut
        @timeout = 30 # Timeout par défaut en secondes
        yield self if block_given?
      end

      # Validates the configuration values.
      def validate!
        raise 'API key is missing. Please configure Ohme::Configuration.api_key.' unless @api_key
        raise 'Base URL is missing. Please configure Ohme::Configuration.base_url.' unless @base_url
        raise 'Domain is missing. Please configure Ohme::Configuration.domain.' unless @domain
        raise 'Version is missing. Please configure Ohme::Configuration.version.' unless @version
      end
    end
  end
end
