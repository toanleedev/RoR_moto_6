module Account
  class AddressesController < ApplicationController
    layout 'account'
    before_action :authenticate_user!
    before_action :init_address

    def show
      respond_to do |format|
        format.html
        format.json { render(json: @address) }
      end
    end

    def update
      if @address.update address_params
        flash[:notice] = 'Update address success'
        redirect_to account_address_path
      else
        flash[:alert] = 'Update address failure'
        init_address
        render :show
      end
    end

    def create
      address = Address.new address_params
      if address.save
        flash[:notice] = t('message.success.create')
      else
        flash[:alert] = t('message.failure.create')
      end
      redirect_to account_address_path
    end

    private

    def address_params
      params.require(:address)
            .permit(:user_id, :province, :district, :ward, :street)
    end

    def init_address
      @address = current_user.address || Address.new
    end
  end
end
