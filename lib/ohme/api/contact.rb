# frozen_string_literal: true

module Ohme
  module API
    # The Contact class provides methods to interact with the Ohme API's
    # contacts endpoint.
    # It allows you to list, create, read, update, and delete contacts.
    class Contact
      # Initializes a new Contact instance with a client.
      #
      # @param client [Ohme::Client] An instance of the Ohme client to
      # make API requests
      # @return [Ohme::API::Contact] A new instance of the Contact class
      def initialize(client = Ohme::Client.new)
        @client = client
      end

      # Fetches the list of contacts
      #
      # @param params [Hash] Optional query parameters
      # @return [Hash] The response from the API
      def index(params = {})
        @client.get('contacts', params)
      end

      # Creates a new contact
      #
      # @param body [Hash] The contact data to be sent in the request body
      # @return [Hash] The response from the API
      def create(body)
        @client.post('contacts', body)
      end

      # Updates a contact by ID
      #
      # @param id [String] The ID of the contact to update
      # @param body [Hash] The contact data to be updated
      # @return [Hash] The response from the API
      def update(id, body)
        @client.put("contacts/#{id}", body)
      end

      # Fetches a contact by ID
      #
      # @param id [String] The ID of the contact to retrieve
      # @return [Hash] The response from the API
      def show(id)
        @client.get("contacts/#{id}")
      end

      # Deletes a contact by ID
      #
      # @param id [String] The ID of the contact to delete
      # @return [nil] The response from the API
      def delete(id)
        @client.delete("contacts/#{id}")
      end
    end
  end
end
