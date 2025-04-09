# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/ohme/configuration'

RSpec.describe Ohme::Configuration do
  before do
    # Reset configuration before each test
    described_class.configure do |config|
      config.api_key = nil
      config.base_url = nil
      config.client_name = nil
      config.version = nil
      config.timeout = nil
    end
  end

  describe '.configure' do
    it 'allows setting configuration attributes' do
      described_class.configure do |config|
        config.api_key = 'test_api_key'
        config.base_url = 'https://api.example.com'
        config.client_name = 'test_client_name'
        config.version = 'v1'
        config.timeout = 60
      end

      expect(described_class.api_key).to eq('test_api_key')
      expect(described_class.base_url).to eq('https://api.example.com')
      expect(described_class.client_name).to eq('test_client_name')
      expect(described_class.version).to eq('v1')
      expect(described_class.timeout).to eq(60)
    end
  end

  describe '.validate!' do
    context 'when the configuration is valid' do
      it 'does not raise an error' do
        described_class.configure do |config|
          config.api_key = 'test_api_key'
          config.base_url = 'https://api.example.com'
          config.client_name = 'test_client_name'
          config.version = 'v1'
        end

        expect { described_class.validate! }.not_to raise_error
      end
    end

    context 'when the API key is missing' do
      it 'raises an error' do
        described_class.configure do |config|
          config.base_url = 'https://api.example.com'
          config.client_name = 'test_client_name'
          config.version = 'v1'
        end

        expect { described_class.validate! }.to raise_error('API key is missing. Please configure Ohme::Configuration.api_key.')
      end
    end

    context 'when the base URL is missing' do
      it 'raises an error' do
        described_class.configure do |config|
          config.api_key = 'test_api_key'
          config.base_url = nil
          config.client_name = 'test_client_name'
          config.version = 'v1'
        end

        expect { described_class.validate! }.to raise_error('Base URL is missing. Please configure Ohme::Configuration.base_url.')
      end
    end

    context 'when the client_name is missing' do
      it 'raises an error' do
        described_class.configure do |config|
          config.api_key = 'test_api_key'
          config.base_url = 'https://api.example.com'
          config.version = nil
        end

        expect { described_class.validate! }.to raise_error('client_name is missing. Please configure Ohme::Configuration.client_name.')
      end
    end
  end
end
