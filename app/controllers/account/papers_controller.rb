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
      else
        flash[:alert] = t('message.failure.create')
      end
      redirect_to account_paper_path
    end

    def update
      if current_user.paper.update paper_params
        flash[:notice] = t('message.success.update')
      else
        flash[:alert] = t('message.failure.update')
      end
      redirect_to request.referrer
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
