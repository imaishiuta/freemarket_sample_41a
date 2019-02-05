class AddressesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  def new
     @address = Address.new
  end

  def create
     @address = Address.new(address_params)
     if @address.save
       redirect_to register_cregit_card_path
     else
       redirect_to new_address_path
     end
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :zip_code, :prefecture, :city, :address1, :address2, :telephone, address_attributes: [:name]).merge(user_id: current_user.id)
  end

end
