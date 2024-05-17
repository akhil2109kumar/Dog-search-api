# require 'rspec'
require 'rest-client'
require 'rails_helper'
require 'json'
# require_relative 'dog_image_fetcher'

RSpec.describe DogImageFetcher do
  describe '.fetch_dog_image_by_breed' do
    let(:breed) { 'husky' }
    let(:image_url) { 'https://example.com/image.jpg' }

    context 'when successful response' do
      before do
        allow(RestClient).to receive(:get).and_return({ 'message' => image_url }.to_json)
      end

      it 'returns the image URL' do
        expect(DogImageFetcher.fetch_dog_image_by_breed(breed)['message']).to eq(image_url)
      end
    end

    context 'when error response' do
      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(nil, 500))
      end

      it 'raises an error' do
        expect { DogImageFetcher.fetch_dog_image_by_breed(breed) }.to raise_error(RestClient::ExceptionWithResponse)
      end
    end
  end
end