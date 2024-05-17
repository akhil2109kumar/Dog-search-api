require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) { { dog_form: { breed: 'boxer'} } }
    let(:invalid_params) { { dog_form: { breed: '', image_url: '' } } }
    let(:fetcher_response) { { 'status' => 'success', 'message' => 'https://example.com/boxer.jpg' } }

    before do
      allow(DogImageFetcher).to receive(:fetch_dog_image_by_breed).and_return(fetcher_response)
    end

    context 'with valid params' do
      it 'creates a new dog' do
        expect {
          post :create, params: valid_params
        }.to change(Dog, :count).by(1)
      end

      it 'returns a successful response with the dog attributes' do
        post :create, params: valid_params
        expect(response).to have_http_status(:success)

        body = JSON.parse(response.body)
        expect(body['breed']).to eq('boxer')
        expect(body['image_url']).to eq('https://example.com/boxer.jpg')
      end
    end

    context 'when breed already exists' do
      let!(:existing_dog) { Dog.create(breed: 'boxer', image_url: 'https://example.com/boxer.jpg') }

      it 'does not create a new dog' do
        expect {
          post :create, params: valid_params
        }.to_not change(Dog, :count)
      end

      it 'returns the existing dog attributes' do
        post :create, params: valid_params
        expect(response).to have_http_status(:success)

        body = JSON.parse(response.body)
        expect(body['breed']).to eq('boxer')
        expect(body['image_url']).to eq('https://example.com/boxer.jpg')
      end
    end

    context 'with invalid params' do
      it 'does not create a new dog' do
        expect {
          post :create, params: invalid_params
        }.to_not change(Dog, :count)
      end

      it 'returns unprocessable entity with an error message' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)

        body = JSON.parse(response.body)
        expect(body['error']).to eq('Dog breed not found')
      end
    end

    context 'when dog image fetch fails' do
      let(:fetcher_response) { { 'status' => 'error', 'message' => 'Breed not found' } }

      it 'does not create a new dog' do
        expect {
          post :create, params: valid_params
        }.to_not change(Dog, :count)
      end

      it 'returns unprocessable entity with an error message' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)

        body = JSON.parse(response.body)
        expect(body['error']).to eq('Dog breed not found')
      end
    end

    it 'raise an exception when the api is unable to fetch the dog image with invalid breed' do
      invalid_params['breed'] = 'abcd'
      post :create, params: invalid_params
      error_message = JSON.parse(response.body)['error']
      expect(error_message).to eq('Dog breed not found')
    end
  end
end
