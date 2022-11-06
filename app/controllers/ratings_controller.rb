class RatingsController < ApplicationController
  def create
    rating = Rating.new rating_params
    if rating.save
      flash[:notice] = t('message.success.create')
    else
      flash[:alert] = t('message.failure.create')
    end
    redirect_to request.referrer
  end

  private

  def rating_params
    params.require(:rating).permit(:content, :order_id, :rating_point).to_h.deep_merge(
      reviewer_id: current_user.id
    )
  end
end
