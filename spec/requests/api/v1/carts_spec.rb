require 'rails_helper'

RSpec.describe 'API V1 Carts', type: :request do
  let(:cart) { create(:cart) }
  let(:green_tea) { create(:green_tea) }

  describe 'POST /api/v1/carts' do
    it 'creates a new cart' do
      expect {
        post '/api/v1/carts'
      }.to change(Cart, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json_response).to include('id')
    end
  end

  describe 'GET /api/v1/carts/:id' do
    it 'returns the cart with items' do
      cart.add_product(green_tea.code)
      
      get "/api/v1/carts/#{cart.id}"
      
      expect(response).to have_http_status(:ok)
      expect(json_response['items'].length).to eq(1)
      expect(json_response['total_price']).to eq(3.11)
    end

    it 'returns not found for invalid id' do
      get '/api/v1/carts/0'
      
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /api/v1/carts/:id/add_item' do
    it 'adds an item to the cart' do
      post "/api/v1/carts/#{cart.id}/add_item", params: { product_code: green_tea.code }
      
      expect(response).to have_http_status(:ok)
      expect(cart.reload.cart_items.count).to eq(1)
      expect(json_response['total_price']).to eq(3.11)
    end

    it 'returns error for invalid product code' do
      post "/api/v1/carts/#{cart.id}/add_item", params: { product_code: 'INVALID' }
      
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /api/v1/carts/:id/remove_item' do
    before do
      cart.add_product(green_tea.code)
    end

    it 'removes an item from the cart' do
      delete "/api/v1/carts/#{cart.id}/remove_item", params: { product_code: green_tea.code }
      
      expect(response).to have_http_status(:ok)
      expect(cart.reload.cart_items.count).to eq(0)
      expect(json_response['total_price']).to eq(0)
    end

    it 'returns error for invalid product code' do
      delete "/api/v1/carts/#{cart.id}/remove_item", params: { product_code: 'INVALID' }
      
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end 