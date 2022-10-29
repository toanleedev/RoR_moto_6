module Admin
  class UsersController < AdminController
    def index
      @users = User.all

      respond_to do |format|
        format.html
        format.json { render json: @users.as_json }
      end
    end

    def reject_paper
      user = User.find_by(id: params[:id])
      return redirect_to request.referrer, alert: t('.user_not_found') unless user.present?

      return if user.paper.rejected?

      user.paper.status = :rejected
      if user.save
        SendNotification.new(user).paper_reject
        redirect_to admin_user_path(user), notice: t('.reject_success')
      else
        redirect_to request.referrer, alert: t('.reject_failure')
      end
    end

    def confirm_paper
      user = User.find_by(id: params[:id])
      return redirect_to request.referrer, alert: t('.user_not_found') unless user.present?

      return if user.paper.confirmed?

      user.paper.status = :confirmed
      user.paper.verified_at = Time.current
      if user.save
        SendNotification.new(user).paper_confirm
        redirect_to admin_user_path(user), notice: t('.confirm_success')
      else
        redirect_to request.referrer, alert: t('.confirm_failure')
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
