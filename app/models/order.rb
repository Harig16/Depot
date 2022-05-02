require 'pago'

class Order < ApplicationRecord
  after_save :shipping_detail_updated 

  has_many :line_items, dependent: :destroy
  enum pay_type: {
    "Check" => 0,
    "Credit Card" => 1,
    "Purchase Order" => 2
  }
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def charge!(pay_type_params)
    payment_details = {}
    payment_method = nil 

    case pay_type
    when "Check"
      payment_method = :check
      payment_details[:routing_number] = pay_type_params[:routing_number]
      payment_details[:account_number] = pay_type_params[:account_number]
    when "Credit Card"
      payment_method = :credit_card
      month, year = pay_type_params[:expiration_date].split(/\//)
      payment_details[:credit_card] = pay_type_params[:credit_card]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year
    when "Purchase Order"
      payment_method = :po
      payment_details[:po_number] = pay_type_params[:po_number]
    end

    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )
    
    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      raise payment_result.error
    end
  end

  private 

    def shipping_detail_updated
      if :ship_date_changed?
        OrderMailer.shipped(self).deliver_later
      end
    end
end
