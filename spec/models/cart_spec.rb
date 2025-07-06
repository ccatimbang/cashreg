require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:cart_items) }
  end

  describe '#add_product' do
    let(:cart) { create(:cart) }
    let(:green_tea) { create(:green_tea) }

    it 'adds a new product to cart' do
      expect { cart.add_product(green_tea.code) }
        .to change { cart.cart_items.count }.by(1)
    end

    it 'increases quantity for existing product' do
      cart.add_product(green_tea.code)
      expect { cart.add_product(green_tea.code) }
        .not_to(change { cart.cart_items.count })
      expect(cart.cart_items.first.quantity).to eq(2)
    end
  end

  describe '#remove_product' do
    let(:cart) { create(:cart) }
    let(:green_tea) { create(:green_tea) }

    before do
      2.times { cart.add_product(green_tea.code) }
    end

    it 'decreases quantity by 1' do
      expect { cart.remove_product(green_tea.code) }
        .not_to(change { cart.cart_items.count })
      expect(cart.cart_items.first.quantity).to eq(1)
    end

    it 'removes item when quantity becomes 0' do
      2.times { cart.remove_product(green_tea.code) }
      expect(cart.cart_items.count).to eq(0)
    end
  end

  describe '#total_price' do
    let(:cart) { create(:cart) }
    let(:green_tea) { create(:green_tea) }
    let(:strawberries) { create(:strawberries) }
    let(:coffee) { create(:coffee) }

    context 'with green tea BOGO offer' do
      it 'applies buy-one-get-one-free' do
        2.times { cart.add_product(green_tea.code) }
        expect(cart.total_price).to eq(3.11)

        cart.add_product(green_tea.code)
        expect(cart.total_price).to eq(6.22)
      end
    end

    context 'with strawberries bulk discount' do
      it 'applies bulk discount for 3 or more' do
        2.times { cart.add_product(strawberries.code) }
        expect(cart.total_price).to eq(10.00)

        cart.add_product(strawberries.code)
        expect(cart.total_price).to eq(13.50)
      end
    end

    context 'with coffee quantity discount' do
      it 'applies 2/3 price for 3 or more' do
        2.times { cart.add_product(coffee.code) }
        expect(cart.total_price).to eq(22.46)

        cart.add_product(coffee.code)
        expected_price = (11.23 * 3 * 2 / 3.0).round(2)
        expect(cart.total_price).to eq(expected_price)
      end
    end

    context 'with mixed items' do
      it 'calculates correct total with all discounts' do
        # Test case from requirements: GR1,SR1,GR1,GR1,CF1
        cart.add_product(green_tea.code) # 3.11
        cart.add_product(strawberries.code) # 5.00
        cart.add_product(green_tea.code)   # Free
        cart.add_product(green_tea.code)   # 3.11
        cart.add_product(coffee.code)      # 11.23

        expect(cart.total_price).to eq(22.45)
      end
    end
  end
end
