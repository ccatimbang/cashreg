require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { build(:green_tea) }

    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_uniqueness_of(:code) }

    it 'validates price is greater than or equal to 0' do
      product = build(:product, price: -1)
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include('must be greater than or equal to 0')
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:cart_items) }
    it { is_expected.to have_many(:carts).through(:cart_items) }
  end
end
