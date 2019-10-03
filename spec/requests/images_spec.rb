require 'rails_helper'

RSpec.describe 'Images API', type: :request do
  let(:image) { create(:image) }

  describe 'POST /image' do
    let(:image_from_local) { { data: { image_url: '/uploads/image.jpg' } } }
    let(:wrong_image_from_local) { { data: { image_url: '/uploads/images.jpg' } } }

    context "creates a image with a file" do
      before { post '/images', params: image_from_local}

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a found message' do
        expect(JSON.parse(response.body)['data']['message']).to eq('Image saved successfully')
      end

      it 'returns an id' do
        expect(JSON.parse(response.body)['data']['id']).not_to be_nil
      end
    end

    context "creates a image with an empty file" do
      before { post '/images', params: wrong_image_from_local}

      it 'returns status code 404' do
        expect(JSON.parse(response.body)['data']['status']).to eq(404)
      end

      it 'returns a found message' do
        expect(JSON.parse(response.body)['data']['message']).to eq('File not found')
      end

      it 'returns an id' do
        expect(JSON.parse(response.body)['data']['id']).to be_nil
      end
    end

    context "params missing" do
      let(:empty_params) { { data: { url: 'image_url' } } }
      before { post '/images', params: empty_params }

      it 'returns status code 422' do
        expect(JSON.parse(response.body)['data']['status']).to eq(422)
      end

      it 'returns a found message' do
        expect(JSON.parse(response.body)['data']['message']).to eq('image_url id required')
      end

      it 'returns an id' do
        expect(JSON.parse(response.body)['data']['id']).to be_nil
      end
    end
  end
end