class CombineItemsInCart < ActiveRecord::Migration[6.0]
  def up
    Cart.all.each do |cart|
      # combine same product with sum of quantity
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        # quantity > 1 then delete all individual entry change into single entry
        if quantity > 1
          cart.line_items.where(product_id: product_id).delete_all

          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    # split the item quantity > 1 into multiple line
    LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do
        LineItem.create!(
          cart_id = line_item.card_id,
          product_id = line_item.product_id,
          quantity = 1
        )
      end
      # remove original item
      line_item.destroy
    end
  end
end
