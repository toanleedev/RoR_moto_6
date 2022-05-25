class ApplicationController < ActionController::Base
  USER_ATTRIBUTES = %w[first_name last_name email birth
                       phone gender current_password].freeze
  before_action :set_locale
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit USER_ATTRIBUTES
    end

    # Delete the key value pairs from params hash if value is empty
    params.delete_if { |_key, value| value.blank? }
  end
end
