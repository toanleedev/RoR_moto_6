module Account
  class PapersController < ApplicationController
    layout 'account'
    before_action :authenticate_user!
    before_action :init_paper

    def show; end

    def create
      paper = Paper.new paper_params
      if paper.save
        flash[:notice] = t('message.success.create')
        redirect_to account_paper_path
      else
        flash[:alert] = t('message.failure.create')
        render 'show'
      end
    end

    def update
      if current_user.paper.update paper_params
        flash[:notice] = t('message.success.update')
        redirect_to account_paper_path
      else
        flash[:alert] = t('message.failure.update')
        render 'show'
      end
    end

    private

    def paper_params
      params.require(:paper).permit(:user_id, :card_number, :card_front_url, :card_back_url,
                                    :driver_number, :driver_front_url)
    end

    def init_paper
      @paper = current_user.paper || Paper.new
    end
  end
end
