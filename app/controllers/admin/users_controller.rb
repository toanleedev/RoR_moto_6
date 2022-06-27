module Admin
  class UsersController < AdminController
    layout 'admin'

    def index
      @users = User.all
    end
  end
end
