# frozen_string_literal: true

require 'json'
require 'spec_helper'
require 'typhoeus'
require_relative '../../lib/ohme/client'
require_relative '../../lib/ohme/configuration'

# rubocop:disable Metrics/BlockLength
RSpec.describe Ohme::Client do
  let(:configuration) do
    Ohme::Configuration.new do |config|
      config.client_secret = 'test_client_secret'
      config.client_name = 'test_client_name'
    end
  end

  let(:client) { described_class.new(configuration) }

  describe '#get' do
    it 'sends a GET request to the correct endpoint' do
      Typhoeus.stub('https://api-ohme.oneheart.fr/api/v1/test_endpoint')
              .and_return(Typhoeus::Response.new(code: 200, body: '{ "success": true }'))

      response = client.get('test_endpoint')

      expect(response).to eq({ 'success' => true })
    end
  end

  describe '#post' do
    it 'sends a POST request with the correct body' do
      Typhoeus.stub('https://api-ohme.oneheart.fr/api/v1/test_endpoint')
              .and_return(Typhoeus::Response.new(code: 201, body: '{ "created": true }'))

      response = client.post('test_endpoint', { key: 'value' })

      expect(response).to eq({ 'created' => true })
    end
  end

  describe '#put' do
    it 'sends a PUT request with the correct body' do
      Typhoeus.stub('https://api-ohme.oneheart.fr/api/v1/test_endpoint')
              .and_return(Typhoeus::Response.new(code: 200, body: '{ "updated": true }'))

      response = client.put('test_endpoint', { key: 'updated_value' })

      expect(response).to eq({ 'updated' => true })
    end
  end

  describe '#delete' do
    it 'sends a DELETE request to the correct endpoint' do
      Typhoeus.stub('https://api-ohme.oneheart.fr/api/v1/test_endpoint')
              .and_return(Typhoeus::Response.new(code: 204, body: ''))

      response = client.delete('test_endpoint')

      expect(response).to eq(nil)
    end
  end

  describe 'error handling' do
    it 'raises an error for a timeout' do
      error_message = 'Request timed out. Please check your network connection or increase the timeout.'
      Typhoeus.stub('https://api-ohme.oneheart.fr/api/v1/test_endpoint')
              .and_return(Typhoeus::Response.new(code: 0, return_code: :operation_timedout, return_message: 'Timeout'))

      expect { client.get('test_endpoint') }.to raise_error(error_message)
    end

    it 'raises an error for a failed request' do
      error_message = 'HTTP request failed: 500 - Internal Server Error'
      Typhoeus.stub('https://api-ohme.oneheart.fr/api/v1/test_endpoint')
              .and_return(Typhoeus::Response.new(code: 500, body: 'Internal Server Error'))

      expect { client.get('test_endpoint') }.to raise_error(error_message)
    end
  end
end
# rubocop:enable Metrics/BlockLength
