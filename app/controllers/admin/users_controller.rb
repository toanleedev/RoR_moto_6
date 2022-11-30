module Admin
  class UsersController < AdminController
    before_action :set_user, except: %i[index]
    def index
      @users = User.all

      respond_to do |format|
        format.html
        format.json { render json: @users.as_json }
      end
    end

    attr_reader :user

    def reject_paper
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
      respond_to do |format|
        format.html
        format.json { render json: @user, serializer: UserSerializer }
      end
    end

    def edit; end

    def update
      if user.update user_params
        flash[:notice] = t('message.success.update')
        redirect_to edit_admin_user_path(user)
      else
        flash[:alert] = t('message.failure.update')
        render 'edit'
      end
    end

    def block
      user.status = :blocked
      if user.save
        redirect_to edit_admin_user_path(user), notice: t('.block_success')
      else
        redirect_to request.referrer, alert: t('.block_failure')
      end
    end

    def unblock
      user.status = :offline
      if user.save
        redirect_to edit_admin_user_path(user), notice: t('.unblock_success')
      else
        redirect_to request.referrer, alert: t('.unblock_failure')
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone, :birth, :gender)
    end

    def set_user
      @user = User.includes(:paper, :address, :vehicles).find_by(id: params[:id])

      return unless @user.blank?

      flash[:alert] = t('.user_not_found')
      redirect_to admin_users_path
    end
  end
end
