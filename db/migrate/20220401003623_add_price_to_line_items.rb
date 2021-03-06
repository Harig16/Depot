class AddPriceToLineItems < ActiveRecord::Migration[6.0]
  def up
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
    
    LineItem.all.each do |line|
      line.price = line.product.price
      line.save!
    end
  end

  def down
    remove_column :line_items, :price
  end
end
