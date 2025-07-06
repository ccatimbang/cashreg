module Api
  module V1
    class CartsController < ApplicationController
      before_action :set_cart, except: [:create]

      def create
        @cart = Cart.create!
        render json: { id: @cart.id }, status: :created
      end

      def show
        render json: {
          id: @cart.id,
          items: @cart.cart_items.includes(:product).map { |item|
            {
              product_code: item.product.code,
              quantity: item.quantity,
              unit_price: item.product.price.to_f,
              total: (item.product.price * item.quantity).round(2)
            }
          },
          total_price: @cart.total_price.to_f
        }
      end

      def add_item
        @cart.add_product(params[:product_code])
        render json: { total_price: @cart.total_price.to_f }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :unprocessable_entity
      end

      def remove_item
        @cart.remove_product(params[:product_code])
        render json: { total_price: @cart.total_price.to_f }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :unprocessable_entity
      end

      private

      def set_cart
        @cart = Cart.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Cart not found' }, status: :not_found
      end
    end
  end
end
