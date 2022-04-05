class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # smart add quantity product from line item controller create action
  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item.price = current_item.total_price
    current_item
  end
  
  def reduce_product(product)
    if product.quantity < 2
      product.destroy
    else
      product.quantity -= 1
      product.price = product.total_price
      product
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
