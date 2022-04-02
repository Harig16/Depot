class StoreController < ApplicationController

  include PageCounter
  include CurrentCart
  before_action :index_counter, only: [:index]
  before_action :set_cart
  
  def index
    @products = Product.order(:title)
    @count = session[:counter]
  end
end
