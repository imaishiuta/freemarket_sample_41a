class AddressesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def new
     @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    path = Rails.application.routes.recognize_path(request.referrer)
    if @address.save
      if path[:controller] == "mypayjp"
        redirect_to product_mypayjp_path(path)
      elsif path[:controller] == "addresses"
        redirect_to register_cregit_card_path
      end
    else
      redirect_to new_address_path
    end
  end

  def edit
    @address = Address.find_by(user_id: current_user.id)
  end

  def update
    @address = Address.find_by(user_id: current_user.id)
    @address.update(address_params)
    path = Rails.application.routes.recognize_path(request.referrer)
    redirect_to product_mypayjp_path(path)
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :zip_code, :prefecture, :city, :address1, :address2, :telephone, address_attributes: [:name]).merge(user_id: current_user.id)
  end

end
