class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :set_default_quantity

  private

  def set_default_quantity
    self.quantity ||= 1
  end
end
