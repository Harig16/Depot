class StoreController < ApplicationController

  include PageCounter
  before_action :index_counter, only: [:index]

  def index
    @products = Product.order(:title)
    @count = session[:counter]
  end
end
