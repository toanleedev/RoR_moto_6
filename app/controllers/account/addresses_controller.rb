module Account
  class AddressesController < ApplicationController
    layout 'account'
    before_action :take_address, only: %i[edit update destroy default_address]
    before_action :authenticate_user!

    def index
      @addresses = current_user.addresses
    end

    def new
      @address = Address.new
      @people = User.all
    end

    def create
      @address = current_user.addresses.new(address_params)

      if @address.save
        flash[:notice] = 'Them dia chi thanh cong'
        redirect_to account_addresses_path
      else
        flash[:alert] = 'Them that bai'
        redirect_to request.referrer
      end
    end

    def edit
      respond_to do |format|
        format.html
        format.json { render(json: @address) }
      end
    end

    def update
      if @address.update address_params
        flash[:notice] = 'Update address success'
        redirect_to account_addresses_path
      else
        flash[:alert] = 'Update address failure'
        redirect_to request.referrer
      end
    end

    def default_address
      binding.pry
      if @address.user.update(address_default_id: params[:id])
        flash[:notice] = 'Update address success'
        redirect_to account_addresses_path
      else
        flash[:alert] = 'Update address failure'
        redirect_to request.referrer
      end
    end

    def destroy
      if @address.destroy
        flash[:notice] = 'Delete address success'
      else
        flash[:alert] = 'Delete address failure'
      end
      redirect_to request.referrer
    end

    def show; end

    private

    def address_params
      params.require(:address).permit(:province, :district, :ward, :street)
    end

    def take_address
      @address = current_user.addresses.find_by_id(params[:id])

      return unless @address.blank?

      flash[:alert] = "Can't found address"
    end
  end
end
