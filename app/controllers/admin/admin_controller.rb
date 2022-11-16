module Admin
  class AdminController < ApplicationController
    layout 'admin'
    include AdminHelper

    before_action :authenticate_user!
    before_action :authenticate_admin

    def authenticate_admin
      redirect_to root_path, alert: t('.not_authorized') unless current_user&.is_admin
    end
  end
end
