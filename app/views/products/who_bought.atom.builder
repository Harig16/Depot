atom_feed do |feed|
  feed.title "Who bought #{@product.title}"

  feed.updated_at @latest_order.try(:updated_at)

  @product.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Order #{order.id}"
      entry.summary type: 'xhtml' do |xhtml|
        xhtml.p "Delivery Address#{order.address}"

        xhtml.table do
          xhtml.tr do
            xhtml.th "Product"
            xhtml.th "Quantity"
            xhtml.th "Price"
          end
          order.line_items.each do |item|
            xhtml.tr do
              xhtml.td item.product.title
              xhtml.td item.quantity
              xhtml.td number_to_currency item.price
            end
          end
          xhtml.tr do
            xhtml.th "Total", colspan: 2
            xhtml.th order.line_items.map(&:total_price).sum
          end
        end

        xhtml.p "Paid by: #{order.pay_type}"
      end
      entry.author do |author|
        author.name order.name
        author.email order.email
      end
    end
  end
end