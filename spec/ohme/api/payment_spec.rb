# frozen_string_literal: true

require "spec_helper"
require_relative "../../../lib/ohme/api/payment"

RSpec.describe Ohme::API::Payment do
  let(:client) { instance_double(Ohme::Client) }
  let(:payment_api) { described_class.new(client) }

  describe "#index" do
    it "fetches the list of payments" do
      expect(client).to receive(:get).with("payments", {}).and_return({"payments" => []})
      response = payment_api.index
      expect(response).to eq({"payments" => []})
    end
  end

  describe "#create" do
    it "creates a new payment" do
      payment_data = {amount: 100, currency: "USD"}
      expect(client).to receive(:post).with("payments", payment_data).and_return({"id" => "123"})
      response = payment_api.create(payment_data)
      expect(response).to eq({"id" => "123"})
    end
  end

  describe "#update" do
    it "updates a payment by ID" do
      payment_data = {amount: 150}
      expect(client).to receive(:put).with("payments/123", payment_data).and_return({"id" => "123", "amount" => 150})
      response = payment_api.update("123", payment_data)
      expect(response).to eq({"id" => "123", "amount" => 150})
    end
  end

  describe "#show" do
    it "fetches a payment by ID" do
      expect(client).to receive(:get).with("payments/123").and_return({"id" => "123", "amount" => 100})
      response = payment_api.show("123")
      expect(response).to eq({"id" => "123", "amount" => 100})
    end
  end

  describe "#delete" do
    it "deletes a payment by ID" do
      expect(client).to receive(:delete).with("payments/123").and_return(nil)
      response = payment_api.delete("123")
      expect(response).to be_nil
    end
  end
end
