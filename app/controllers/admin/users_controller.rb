module Admin
  class UsersController < AdminController
    def index
      @users = User.all

      respond_to do |format|
        format.html
        format.json { render json: @users.as_json }
      end
    end

    def show
      @user = User.includes(:paper, :address, :vehicles).find_by(id: params[:id])

      respond_to do |format|
        format.html
        format.json { render json: @user, serializer: UserSerializer }
      end
    end
  end
end
