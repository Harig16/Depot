class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  def total_price
    product.price * quantity
  end

  # Query the product detail with corresponding line_items and orders
  #select line_items.product_id, products.title, products.price, line_items.price from line_items INNER JOIN products on line_items.product_id = products.id where exists (select orders.id from orders where line_items.order_id = orders.id);
end
