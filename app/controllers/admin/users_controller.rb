module Admin
  class UsersController < AdminController
    layout 'admin'

    def index
      @users = User.all
    end

    def show
      @user = User.find_by(id: params[:id])
      # binding.pry
      respond_to do |format|
        format.json { render json: @user, serializer: UserSerializer}
      end
    end
  end
end
