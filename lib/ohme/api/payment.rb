# frozen_string_literal: true

module Ohme
  module API
    class Payment
      def initialize(client = Ohme::Client.new)
        @client = client
      end

      # Fetches the list of payments
      # @param params [Hash] Optional query parameters
      # @return [Hash] The response from the API
      def index(params = {})
        @client.get('payments', params)
      end

      # Creates a new payment
      # @param body [Hash] The payment data to be sent in the request body
      # @return [Hash] The response from the API
      def create(body)
        @client.post('payments', body)
      end

      # Updates a payment by ID
      # @param id [String] The ID of the payment to update
      # @param body [Hash] The payment data to be updated
      # @return [Hash] The response from the API
      def update(id, body)
        @client.put("payments/#{id}", body)
      end

      # Fetches a payment by ID
      # @param id [String] The ID of the payment to retrieve
      # @return [Hash] The response from the API
      def show(id)
        @client.get("payments/#{id}")
      end

      # Deletes a payment by ID
      # @param id [String] The ID of the payment to delete
      # @return [nil] The response from the API
      def delete(id)
        @client.delete("payments/#{id}")
      end
    end
  end
end
