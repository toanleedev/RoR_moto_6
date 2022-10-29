module Admin
  class PartnersController < AdminController
    before_action :set_partner, except: [:index]
    attr_accessor :partner

    def index
      @partners = PartnerHistory.order('created_at DESC').all

      respond_to do |format|
        format.html
        format.json { render json: @partners }
      end
    end

    def confirm
      user = partner.user

      return redirect_to admin_partners_path if partner.confirmed? || user.is_partner

      partner.status = :confirmed
      user.is_partner = true

      if partner.save && user.save
        SendNotification.new(user).partner_confirm
        flash[:notice] = t('message.success.update')
      else
        flash[:alert] = t('message.failure.update')
      end

      redirect_to admin_partners_path
    end

    def cancel
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
      @partner = PartnerHistory.find_by(id: params[:id])
      return unless partner.present?
    end
  end
end
