json.product do 
  json.title @product.title
  json.updated_at @latest_order.try(:updated_at)
  json.orders @product.orders.each do |order|
    json.order_id order.id
    json.address order.address

    json.item order.line_items.each do |line_item|
      json.product_title line_item.product.title
      json.quantity line_item.quantity
      json.price number_to_currency line_item.total_price
    end

    json.total_amount number_to_currency order.line_items.map(&:total_price).sum

    json.pay_type order.pay_type

    json.customer order.name
    json.customer_email order.email
  end
end

