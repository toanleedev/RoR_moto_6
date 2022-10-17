class StaticPagesController < ApplicationController
  def index
    @time_now = Time.new.strftime('%Y-%m-%dT%k:%M')
    # SendNotificationJob.perform_now(current_user, account_order_path(Order.last))
  end
end
