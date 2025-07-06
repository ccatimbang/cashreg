module Api
  module V1
    class ProductsController < ApplicationController
      def index
        @products = Product.all
        render json: @products.map { |product| product_json(product) }
      end

      def show
        @product = Product.find(params[:id])
        render json: product_json(@product)
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :not_found
      end

      private

      def product_json(product)
        {
          id: product.id,
          code: product.code,
          name: product.name,
          price: product.price.to_f
        }
      end
    end
  end
end
