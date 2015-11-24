class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :now, if: :whitelist
  before_action :authorize
  before_action :set_i18n_locale_from_params
  before_action :current_user

  def now
    @time = Time.zone.now.strftime("%Y年%m月%d日<br/>%H:%M:%S")
  end

  private

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to(login_url, notice: "ログインしてください")
      end
    end

    def whitelist
      %w{carts store products}.include?(controller_name)
    end

    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
    end
end
