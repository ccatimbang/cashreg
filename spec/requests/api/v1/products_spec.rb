require 'rails_helper'

RSpec.describe 'API V1 Products', type: :request do
  describe 'GET /api/v1/products' do
    before do
      create(:green_tea)
      create(:strawberries)
      create(:coffee)
    end

    it 'returns all products' do
      get '/api/v1/products'
      
      expect(response).to have_http_status(:ok)
      expect(json_response.length).to eq(3)
      expect(json_response.first.keys).to include('id', 'code', 'name', 'price')
    end
  end

  describe 'GET /api/v1/products/:id' do
    let(:product) { create(:green_tea) }

    it 'returns the product' do
      get "/api/v1/products/#{product.id}"
      
      expect(response).to have_http_status(:ok)
      expect(json_response['code']).to eq('GR1')
      expect(json_response['name']).to eq('Green Tea')
      expect(json_response['price']).to eq(3.11)
    end

    it 'returns not found for invalid id' do
      get '/api/v1/products/0'
      
      expect(response).to have_http_status(:not_found)
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end 