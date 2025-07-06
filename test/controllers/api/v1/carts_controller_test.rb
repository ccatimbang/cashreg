require 'test_helper'

module Api
  module V1
    class CartsControllerTest < ActionDispatch::IntegrationTest
      test 'should get show' do
        get api_v1_carts_show_url
        assert_response :success
      end

      test 'should get create' do
        get api_v1_carts_create_url
        assert_response :success
      end

      test 'should get add_product' do
        get api_v1_carts_add_product_url
        assert_response :success
      end

      test 'should get remove_product' do
        get api_v1_carts_remove_product_url
        assert_response :success
      end
    end
  end
end
