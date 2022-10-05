module Account
  class PapersController < ApplicationController
    layout 'account'
    before_action :authenticate_user!
    before_action :init_paper

    def show; end

    def create
      paper = Paper.new paper_params
      if paper.save
        flash[:notice] = t('.create_success')
        redirect_to account_paper_path
      else
        flash[:alert] = t('.create_failure')
        render 'show'
      end
    end

    def update
      if current_user.paper.update paper_params
        flash[:notice] = t('.update_success')
        redirect_to account_paper_path
      else
        flash[:alert] = t('.update_failure')
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
