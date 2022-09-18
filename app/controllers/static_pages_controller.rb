class StaticPagesController < ApplicationController
  def index
    @time_now = Time.new.strftime('%Y-%m-%dT%k:%M')
  end
end
