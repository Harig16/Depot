class StoreController < ApplicationController
  skip_before_action :authorize
  include PageCounter
  include CurrentCart
  before_action :index_counter, only: [:index]
  before_action :set_cart

  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.all.order(:title)
      @count = session[:counter]
    end
  end
end
