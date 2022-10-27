module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      # self.current_user = User.find_by(id: 5)
    end

    private

    # def find_verified_user
    #   if user_id == cookies.signed[:user_id] || request.session[:user_id]
    #     User.find_by(id: 5) || reject_unauthorized_connection
    #   end
    # end
  end
end
