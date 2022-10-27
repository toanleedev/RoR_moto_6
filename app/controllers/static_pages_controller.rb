class StaticPagesController < ApplicationController
  def index
    @time_now = Time.new.strftime('%Y-%m-%dT%k:%M')
    NotificationBroadcastJob.perform_now()
  end
end
