class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: USER_ATTRIBUTES)
    devise_parameter_sanitizer.permit(:sign_up, keys: USER_REGISTER_ATTRIBUTES)
    devise_parameter_sanitizer.permit :accept_invitation, keys: [:email]
    # Delete the key value pairs from params hash if value is empty
    params.delete_if { |_key, value| value.blank? }
  end

  USER_ATTRIBUTES = %w[
    first_name
    last_name
    email
    birth
    phone
    gender
    current_password
    password
    password_confirmation
    photo_url
    photo_url_cache
    remove_photo_url
  ].freeze

  USER_REGISTER_ATTRIBUTES = %w[
    first_name
    last_name
    email
    password
    password_confirmation
  ].freeze

  private

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options
    { locale: set_locale }
  end
end
