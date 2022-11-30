class PartnersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_partner

  def show
    @partner = current_user.partner_history || PartnerHistory.new
  end

  def create
    partner = PartnerHistory.new partner_params
    if partner.save
      notify_params = {
        sender_id: partner.user_id,
        receiver_id: User.admins.first.id,
        on_click_url: 'admin/partners',
        notify_type: :admin,
        title: 'notification.title.partner_request',
        content: 'notification.content.partner_request'
      }
      SendNotification.new(notify_params).call
      flash[:notice] = t('message.success.create')
      redirect_to partner_path
    else
      flash[:alert] = t('message.failure.create')
      @partner = partner
      render 'show'
    end
  end

  def update
    @partner = current_user.partner_history
    @partner.status = :pending
    if @partner.update partner_params
      flash[:notice] = t('message.success.update')
      redirect_to partner_path
    else
      @partner.status = :canceled
      render 'show'
    end
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
