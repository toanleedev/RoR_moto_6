module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include ActionController::Cookies
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      key = Rails.application.config.session_options.fetch(:key)
      cookies.encrypted[key]&.symbolize_keys[:"warden.user.user.key"][0][0]
      user_id = cookies.encrypted[key]&.symbolize_keys[:"warden.user.user.key"][0][0]
      User.find_by(id: user_id) || reject_unauthorized_connection
    end
  end
end
