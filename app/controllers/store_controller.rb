class StoreController < ApplicationController
  skip_before_action :authorize

  def index
    @products = Product.order(:title)

    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end

    if session[:counter] >= 5
      @counter = "<p>あなたはこのページを#{session[:counter]}回訪問しています。</p>"
    end

    @cart = current_cart
  end
end
