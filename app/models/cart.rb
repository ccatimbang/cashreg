class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_code)
    product = Product.find_by!(code: product_code)
    cart_item = cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = (cart_item.quantity || 0) + 1
    cart_item.save!
  end

  def remove_product(product_code)
    product = Product.find_by!(code: product_code)
    cart_item = cart_items.find_by!(product: product)

    cart_item.quantity -= 1
    if cart_item.quantity <= 0
      cart_item.destroy!
    else
      cart_item.save!
    end
  end

  def total_price
    PricingService.new.calculate_total(self).round(2)
  end

  def as_json(options = {})
    super.merge(
      total_price: total_price,
      cart_items: cart_items.as_json(include: :product)
    )
  end
end
