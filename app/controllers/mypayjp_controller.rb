class MypayjpController < ApplicationController

  before_filter :authenticate_user!, only: [:show, :create_charge]
  before_action :set_product, only: [:show, :create_charge]

require 'payjp'

  def show
    if current_user.id == @product.seller
      redirect_to product_path
    end
    @user = current_user
    @area = Area.find_by(id: current_user.address.prefecture)
    @product_images = ProductImage.find_by(product_id: params[:id])
  end

  def create_charge
    @product = Product.find(params[:id])
    customer_id = current_user.payjp_id
    point = params[:point].to_i
    amount = @product.price - point
    if current_user.point
      save_users_point(point, amount)
    end
    if amount == 0
      @trade = Trade.find_by(product_id: params[:id])
      @trade.user_id = current_user.id
      @trade.save
    end
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    PaysHelper.create_charge(amount, customer_id)
    Trade.transaction do
      @trade = Trade.find_by(product_id: params[:id])
      @trade.user_id = current_user.id
      @trade.save
      save_sellers_point(@product, amount)
    end
      redirect_to root_path
    rescue
      redirect_to product_path

  end

  def set_product
    @product = Product.find(params[:id])
  end

end
