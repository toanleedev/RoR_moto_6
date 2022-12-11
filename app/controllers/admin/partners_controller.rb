module Admin
  class PartnersController < AdminController
    before_action :set_partner, except: [:index]
    attr_accessor :partner

    def index
      @partners = Partner.order('created_at DESC').all

      respond_to do |format|
        format.html
        format.json { render json: @partners }
      end
    end

    def confirm
      user = partner.user

      return redirect_to admin_partners_path if partner.confirmed? || user.partner?

      partner.status = :confirmed
      user.is_partner = true

      if partner.save && user.save
        send_notification_confirm(user)
        flash[:notice] = t('message.success.update')
      else
        flash[:alert] = t('message.failure.update')
      end

      redirect_to admin_partners_path
    end

    def cancel
      user = partner.user
      partner.status = :canceled

      if partner.save
        SendNotification.new(user).partner_reject
        flash[:notice] = t('message.success.update')
      else
        flash[:alert] = t('message.failure.update')
      end

      redirect_to admin_partners_path
    end

    private

    def set_partner
      @partner = Partner.find_by(id: params[:id])
      return unless partner.present?
    end

    def send_notification_confirm(user)
      param = {
        receiver_id: user.id,
        on_click_url: 'partners/order_manages',
        title: 'notification.title.partner_confirm',
        content: 'notification.content.partner_confirm'
      }
      SendNotification.new(param).call
    end
  end
end
