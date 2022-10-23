class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def create
    notification = Notification.find_by(id: params[:id])

    return unless notification.present?

    unless notification.checked_at.present?
      notification.checked_at = Time.current
      notification.save
    end

    redirect_to "/#{I18n.locale}/#{notification.on_click_url}" if notification.on_click_url.present?
  end
end
