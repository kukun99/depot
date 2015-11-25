class StoreController < ApplicationController
  skip_before_action :authorize

  def index
    if params[:set_locale]
      redirect_to(store_url(locale: params[:set_locale]))
    else
      @products = Product.order(:title)
      # @cart = current_cart
    end

    @products = Product.order(:title)
    @cart = current_cart

    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end

    if session[:counter] >= 5
      @counter = "<p>あなたはこのページを#{session[:counter]}回訪問しています。</p>"
    end
  end
end
