module Admin
  class AdminController < ApplicationController
    layout 'admin'
    include AdminHelper

    before_action :authenticate_user!
    before_action :authenticate_admin

    def index; end

    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless current_user&.is_admin
    end
  end
end
