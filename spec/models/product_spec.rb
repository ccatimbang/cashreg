require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { build(:green_tea) }

    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_uniqueness_of(:code) }
    
    it 'validates price is greater than or equal to 0' do
      product = build(:product, price: -1)
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include('must be greater than or equal to 0')
    end
  end

  describe 'associations' do
    it { should have_many(:cart_items) }
    it { should have_many(:carts).through(:cart_items) }
  end
end 