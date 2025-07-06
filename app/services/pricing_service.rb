class PricingService
  def calculate_item_price(product, quantity)
    case product.code
    when 'GR1' # Green Tea - Buy one get one free
      paying_quantity = (quantity.to_f / 2).ceil
      (paying_quantity * product.price).round(2)
    when 'SR1' # Strawberries - Bulk discount
      price = quantity >= 3 ? 4.50 : product.price
      (quantity * price).round(2)
    when 'CF1' # Coffee - Quantity discount
      if quantity >= 3
        (quantity * product.price * 2/3.0).round(2)
      else
        (quantity * product.price).round(2)
      end
    else
      (quantity * product.price).round(2)
    end
  end

  def calculate_total(cart)
    cart.cart_items.includes(:product).sum do |item|
      calculate_item_price(item.product, item.quantity)
    end.round(2)
  end
end 