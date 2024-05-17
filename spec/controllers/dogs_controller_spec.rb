require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) { { dog_form: { breed: 'boxer', image_url: 'https://example.com/labrador.jpg' } } }
    let(:invalid_params) { { dog_form: { breed: '', image_url: '' } } }

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
  end
end
