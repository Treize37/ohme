# frozen_string_literal: true

require "spec_helper"
require_relative "../../../lib/ohme/api/contact"

# rubocop:disable Metrics/BlockLength
RSpec.describe Ohme::API::Contact do
  let(:client) { instance_double(Ohme::Client) }
  let(:contact_api) { described_class.new(client) }

  describe "#index" do
    it "fetches the list of contacts" do
      expect(client).to receive(:get).with("contacts", {}).and_return({"contacts" => []})
      response = contact_api.index
      expect(response).to eq({"contacts" => []})
    end
  end

  describe "#create" do
    it "creates a new contact" do
      contact_data = {name: "John Doe", email: "john.doe@example.com"}
      expect(client).to receive(:post).with("contacts", contact_data).and_return({"id" => "123"})
      response = contact_api.create(contact_data)
      expect(response).to eq({"id" => "123"})
    end
  end

  describe "#update" do
    it "updates a contact by ID" do
      contact_data = {name: "Jane Doe"}
      expect(client).to receive(:put).with("contacts/123",
        contact_data).and_return({"id" => "123", "name" => "Jane Doe"})
      response = contact_api.update("123", contact_data)
      expect(response).to eq({"id" => "123", "name" => "Jane Doe"})
    end
  end

  describe "#show" do
    it "fetches a contact by ID" do
      expect(client).to receive(:get).with("contacts/123").and_return({"id" => "123", "name" => "John Doe"})
      response = contact_api.show("123")
      expect(response).to eq({"id" => "123", "name" => "John Doe"})
    end
  end

  describe "#delete" do
    it "deletes a contact by ID" do
      expect(client).to receive(:delete).with("contacts/123").and_return(nil)
      response = contact_api.delete("123")
      expect(response).to be_nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
