module Partners
  class RegistersController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_partner

    def show
      @partner = current_user.partner || Partner.new
    end

    def create
      partner = Partner.new partner_params
      if partner.save
        flash[:notice] = t('message.success.create')
        redirect_to partners_register_path
      else
        flash[:alert] = t('message.failure.create')
        @partner = partner
        render 'show'
      end
    end

    def update
      @partner = current_user.partner
      @partner.status = :pending
      if @partner.update partner_params
        flash[:notice] = t('message.success.update')
        redirect_to partners_register_path
      else
        @partner.status = :canceled
        render 'show'
      end
    end

    private

    def partner_params
      params.require(:partner).permit(:name, :email, :phone,
                                      :address, :user_kind, :title,
                                      :description, :tax_code, :user_id)
    end

    def send_notification(partner)
      notify_params = {
        sender_id: partner.user_id,
        receiver_id: User.admins.first.id,
        on_click_url: 'admin/partners',
        notify_type: :admin,
        title: 'notification.title.partner_request',
        content: 'notification.content.partner_request'
      }
      SendNotification.new(notify_params).call
    end

    def authenticate_partner
      if current_user.paper.blank?
        return redirect_to account_paper_path, alert: t('.unconfirmed_paper')
      end

      if current_user.address.blank?
        return redirect_to account_address_path, alert: t('.unconfirmed_address')
      end

      redirect_to partners_order_manages_path, alert: t('.not_authorized') if current_user.partner?
    end
  end
end
