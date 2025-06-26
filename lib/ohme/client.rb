# frozen_string_literal: true

require 'typhoeus'
require_relative 'configuration'

module Ohme
  # Client for interacting with the Ohme API
  class Client
    # Initializes the client with the configuration
    #
    # @param configuration [Ohme::Configuration] The configuration object
    # @return [Ohme::Client] A new instance of the Ohme client
    def initialize(configuration = Ohme::Configuration.new)
      @configuration = configuration
      @configuration.validate!
    end

    # Performs a GET request
    #
    # @param endpoint [String] The API endpoint to request
    # @param params [Hash] Optional query parameters
    # @return [Hash] The response from the API
    def get(endpoint, params = {})
      request(:get, endpoint, params: params)
    end

    # Performs a POST request
    #
    # @param endpoint [String] The API endpoint to request
    # @param body [Hash] The request body to send
    # @return [Hash] The response from the API
    def post(endpoint, body = {})
      request(:post, endpoint, body: body)
    end

    # Performs a PUT request
    #
    # @param endpoint [String] The API endpoint to request
    # @param body [Hash] The request body to send
    # @return [Hash] The response from the API
    def put(endpoint, body = {})
      request(:put, endpoint, body: body)
    end

    # Performs a DELETE request
    #
    # @param endpoint [String] The API endpoint to request
    # @param params [Hash] Optional query parameters
    # @return [nil] The response from the API (nil for DELETE requests)
    def delete(endpoint, params = {})
      request(:delete, endpoint, params: params)
    end

    private

    # Private: Performs an HTTP request
    #
    # @param method [Symbol] The HTTP method (get, post, put, delete)
    # @param endpoint [String] The API endpoint to request
    # @param options [Hash] Optional parameters for the request
    # @return [Hash, nil] The parsed response from the API or nil for DELETE
    def request(method, endpoint, options = {})
      response = Typhoeus::Request.new(
        build_url(endpoint),
        method: method,
        headers: build_headers,
        params: options[:params],
        body: options[:body]&.to_json,
        timeout: @configuration.timeout
      ).run

      handle_response(response)
    end

    # Private: Builds the full URL for the API request
    #
    # @param endpoint [String] The API endpoint to request
    # @return [String] The full URL for the request
    def build_url(endpoint)
      "#{@configuration.base_url}#{@configuration.version}/#{endpoint}"
    end

    # Private: Builds the headers for the request
    #
    # @return [Hash] The headers to be sent with the request
    def build_headers
      {
        'client-name' => @configuration.client_name,
        'client-secret' => @configuration.client_secret,
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    # Private: Handles the API response
    #
    # @param response [Typhoeus::Response] The response from the API
    # @return [Hash, nil] The parsed response or nil for DELETE requests
    def handle_response(response)
      if response.timed_out?
        raise 'Request timed out. Please check your network connection or increase the timeout.'
      elsif response.success?
        # Return nil for DELETE requests with no body
        return nil if response.body.nil? || response.body.strip.empty?

        # Parse JSON for other successful responses
        JSON.parse(response.body)
      else
        raise "HTTP request failed: #{response.code} - #{response.body}"
      end
    end
  end
end
