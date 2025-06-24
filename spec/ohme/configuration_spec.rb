# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/ohme/configuration"

# rubocop:disable Metrics/BlockLength
RSpec.describe Ohme::Configuration do
  describe ".new" do
    let(:conf) do
      described_class.new do |config|
        config.base_url = "https://api.example.com"
        config.client_name = "test_client_name"
        config.client_secret = "test_client_secret"
        config.timeout = 60
        config.version = "v1"
      end
    end

    describe "setting configuration attributes" do
      it "sets the client_secret attribute correctly" do
        expect(conf.client_secret).to eq("test_client_secret")
      end

      it "sets the base_url attribute correctly" do
        expect(conf.base_url).to eq("https://api.example.com")
      end

      it "sets the client_name attribute correctly" do
        expect(conf.client_name).to eq("test_client_name")
      end

      it "sets the version attribute correctly" do
        expect(conf.version).to eq("v1")
      end

      it "sets the timeout attribute correctly" do
        expect(conf.timeout).to eq(60)
      end
    end
  end

  describe "#validate!" do
    let(:conf) { described_class.new }

    context "when all required attributes are set" do
      it "does not raise an error" do
        conf.client_name = "test_client_name"
        conf.client_secret = "test_client_secret"

        expect { conf.validate! }.not_to raise_error
      end
    end

    context "when client_name is missing" do
      it "raises an error" do
        error_message = "client_name is missing. " \
                          "Please configure Ohme::Configuration.client_name."
        conf.client_secret = "test_client_secret"

        expect { conf.validate! }.to raise_error(error_message)
      end
    end

    context "when client_secret is missing" do
      it "raises an error" do
        error_message = "client_secret is missing. " \
                          "Please configure Ohme::Configuration.client_secret."
        conf.client_name = "test_client_name"

        expect { conf.validate! }.to raise_error(error_message)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
