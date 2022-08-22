module Account
  class PapersController < ApplicationController
    layout 'account'
    before_action :authenticate_user!
    before_action :paper, only: %i[index]

    def index; end

    def new
      @paper = Paper.new
    end

    def create
      paper = Paper.new paper_params
      if paper.save
        flash[:notice] = t('message.success.create')
      else
        flash[:alert] = t('message.failure.create')
      end
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

    def paper
      @paper ||= current_user.paper
    end
  end
end
