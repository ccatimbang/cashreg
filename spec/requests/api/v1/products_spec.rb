require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  describe 'GET /api/v1/products' do
    let!(:products) { create_list(:product, 3) }

    it 'returns http success' do
      get '/api/v1/products'
      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(a_string_including('application/json'))
      expect(response.parsed_body.length).to eq(3)
    end

    it 'returns the correct product data' do
      get '/api/v1/products'
      products.each do |product|
        expect(response.parsed_body).to include(
          include(
            'code' => product.code,
            'name' => product.name,
            'price' => product.price.to_s
          )
        )
      end
    end
  end
end
