class ApplicationController < ActionController::Base
  before_action :set_locale, :init_cart, :init_ransack

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:last_name, :first_name, :email, :phone,
                  :password, :password_confirmation, :date_of_birth]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def init_cart
    session[:cart] ||= {}
  end

  def init_ransack
    @q = Room.ransack params[:q], auth_object: set_ransack_auth_object
  end

  def is_admin?
    return if current_user.admin?

    flash[:warning] = t "receipt.not_permissions"
    redirect_to root_url
  end

  def set_ransack_auth_object
    current_user&.admin? ? :admin : nil
  end
end
