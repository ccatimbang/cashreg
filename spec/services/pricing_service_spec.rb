require 'rails_helper'

RSpec.describe PricingService do
  let(:service) { described_class.new }
  let(:green_tea) { create(:green_tea) }
  let(:strawberries) { create(:strawberries) }
  let(:coffee) { create(:coffee) }

  describe '#calculate_item_price' do
    context 'with green tea BOGO offer' do
      it 'calculates price for odd quantities' do
        price = service.calculate_item_price(green_tea, 3)
        expect(price).to eq(6.22) # Pay for 2
      end

      it 'calculates price for even quantities' do
        price = service.calculate_item_price(green_tea, 4)
        expect(price).to eq(6.22) # Pay for 2
      end
    end

    context 'with strawberries bulk discount' do
      it 'applies normal price for quantities under 3' do
        price = service.calculate_item_price(strawberries, 2)
        expect(price).to eq(10.00)
      end

      it 'applies bulk discount for quantities of 3 or more' do
        price = service.calculate_item_price(strawberries, 3)
        expect(price).to eq(13.50) # 3 * 4.50
      end
    end

    context 'with coffee quantity discount' do
      it 'applies normal price for quantities under 3' do
        price = service.calculate_item_price(coffee, 2)
        expect(price).to eq(22.46)
      end

      it 'applies quantity discount for 3 or more' do
        price = service.calculate_item_price(coffee, 3)
        expected_price = (11.23 * 3 * 2 / 3.0).round(2)
        expect(price).to eq(expected_price)
      end
    end
  end

  describe '#calculate_total' do
    let(:cart) { create(:cart) }

    before do
      cart.add_product(green_tea.code)
      cart.add_product(strawberries.code)
      cart.add_product(coffee.code)
    end

    it 'calculates total price with mixed items' do
      total = service.calculate_total(cart)
      expect(total).to eq(19.34) # 3.11 + 5.00 + 11.23
    end

    it 'applies all discounts correctly' do
      2.times { cart.add_product(green_tea.code) }
      2.times { cart.add_product(strawberries.code) }
      2.times { cart.add_product(coffee.code) }

      total = service.calculate_total(cart)
      expected_total = (
        (3.11 * 2) +           # 2 paid green teas (2 free)
        (4.50 * 3) +           # 3 strawberries at bulk price
        (11.23 * 3 * 2 / 3.0)  # 3 coffees at 2/3 price
      ).round(2)

      expect(total).to eq(expected_total)
    end
  end
end
