class PartnersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_partner

  def show
    @partner = current_user.partner_history || PartnerHistory.new
  end

  def create
    partner = PartnerHistory.new partner_params
    if partner.save
      flash[:notice] = t('message.success.create')
    else
      flash[:alert] = t('message.failure.create')
    end
    redirect_to partner_path
  end

  private

  def partner_params
    params.require(:partner_history).permit(:full_name, :email, :phone,
                                            :address, :user_kind, :title,
                                            :description, :tax_code, :user_id)
  end

  def authenticate_partner
    redirect_to root_path, notice: t('.not_authorized') if current_user.is_partner
  end
end
