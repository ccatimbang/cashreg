class PricingService
  def calculate_item_price(product, quantity)
    case product.code
    when 'GR1' # Green Tea
      calculate_green_tea_price(product.price, quantity)
    when 'SR1' # Strawberries
      calculate_strawberry_price(product.price, quantity)
    when 'CF1' # Coffee
      calculate_coffee_price(product.price, quantity)
    else
      product.price * quantity
    end
  end

  private

  def calculate_green_tea_price(price, quantity)
    paid_quantity = (quantity / 2.0).ceil
    price * paid_quantity
  end

  def calculate_strawberry_price(price, quantity)
    bulk_price = quantity >= 3 ? 4.50 : price
    bulk_price * quantity
  end

  def calculate_coffee_price(price, quantity)
    discount_price = (price * 2 / 3.0).round(2)
    quantity >= 3 ? discount_price * quantity : price * quantity
  end
end
