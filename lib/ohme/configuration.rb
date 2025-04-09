# frozen_string_literal: true

module Ohme
  # Configuration of the Ohme API client gem.
  module Configuration
    class << self
      attr_accessor :client_secret, :base_url, :timeout, :client_name, :version

      # Initializes the configuration with default values.
      def configure
        @base_url = 'https://api-ohme.oneheart.fr/api/' # Nouvelle URL de base
        @version = 'v1' # Version par défaut
        @timeout = 30 # Timeout par défaut en secondes
        yield self if block_given?
      end

      # Validates the configuration values.
      def validate!
        raise 'client_secret key is missing. Please configure Ohme::Configuration.client_secret.' unless @client_secret
        raise 'Base URL is missing. Please configure Ohme::Configuration.base_url.' unless @base_url
        raise 'client_name is missing. Please configure Ohme::Configuration.client_name.' unless @client_name
        raise 'Version is missing. Please configure Ohme::Configuration.version.' unless @version
      end
    end
  end
end
