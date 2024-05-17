require 'rails_helper'
require 'json'

RSpec.describe DogImageFetcher, type: :service do
  describe '.fetch_dog_image_by_breed' do
    context 'when the Dog API request is successful' do
      let(:dog_image_url) { 'https://example.com/dog.jpg' }
      let(:response_body) { { 'message' => dog_image_url }.to_json }

      before do
        allow(RestClient).to receive(:get).and_return(double(code: 200, body: response_body))
      end

      it 'returns the dog image URL' do
        breed = 'dachshund'
        expect(DogImageFetcher.fetch_dog_image_by_breed(breed)).to eq(dog_image_url)
      end
    end

    context 'when the Dog API request fails with an error response' do
      let(:error_message) { 'API error response' }

      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(double(body: error_message, code: 500)))
      end

      it 'logs an error and returns nil' do
        breed = 'abcd'
        expect(Rails.logger).to receive(:error).with(/Dog API request failed/)
        expect(DogImageFetcher.fetch_dog_image_by_breed(breed)).to be_nil
      end
    end

    context 'when an unexpected error occurs during the Dog API request' do
      let(:error_message) { 'Unexpected error' }

      before do
        allow(RestClient).to receive(:get).and_raise(StandardError, error_message)
      end

      it 'logs an error and returns nil' do
        breed = ''
        expect(Rails.logger).to receive(:error).with(/Error while fetching dog image/)
        expect(DogImageFetcher.fetch_dog_image_by_breed(breed)).to be_nil
      end
    end
  end

  describe '.handle_response' do
    it 'returns the dog image URL when the response code is 200' do
      response_body = { 'message' => 'https://example.com/dog.jpg' }.to_json
      response = double(code: 200, body: response_body)

      expect(DogImageFetcher.send(:handle_response, response)).to eq('https://example.com/dog.jpg')
    end

    it 'returns nil when the response code is not 200' do
      response = double(code: 500, body: 'Internal Server Error')

      expect(DogImageFetcher.send(:handle_response, response)).to be_nil
    end
  end

  describe '.handle_error' do
    it 'logs the error message' do
      error_message = 'An error occurred'
      expect(Rails.logger).to receive(:error).with(/#{error_message}/)
      DogImageFetcher.send(:handle_error, error_message)
    end
  end
end
