class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true
end
