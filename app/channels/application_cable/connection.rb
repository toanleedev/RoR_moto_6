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
      session = cookies.encrypted[key]&.symbolize_keys[:"warden.user.user.key"]
      if session.present?
        user_id = session[0][0]
      else
        reject_unauthorized_connection
      end
      User.find_by(id: user_id) || reject_unauthorized_connection
    end
  end
end
