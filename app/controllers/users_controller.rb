class UsersController < ApplicationController

  before_filter :authenticate_user!, only: [:register_cregit_card, :update, :pay, :create_charge]

  require 'payjp'

  before_action :set_category
  before_action :set_user, only: [:update]
  protect_from_forgery except: :pay

  def index
    @purchase_products = current_user.purchase_products
    @user = User.find(1)
    @rate_count = current_user.buyer_rates.count + current_user.seller_rates.count
  end

  def update
    if @user.id == current_user.id
      current_user.update(update_user_profile)
    end
    redirect_to users_path
  end

  def register_cregit_card
  end

  def purchase
    @purchase_products = current_user.purchase_products
  end

  def purchased
    @purchase_products = current_user.purchase_products
  end

  def listings
    @products = current_user.products
  end

  def progress
    @products = current_user.products
  end

  def completed
    @products = current_user.products
  end

  def pay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    path = Rails.application.routes.recognize_path(request.referrer)
    @user = User.find(current_user)
    exp_yaer = '20' + params[:year]
    @user.cardtoken = PaysHelper.create_token(params[:number], params[:month], exp_yaer, params[:cvc]).id
    if @user.save
      token = @user.cardtoken
      customer_id = Payjp::Customer.create(card: token).id
      @user.payjp_id = customer_id
      @user.save
      if path[:controller] == "mypayjp"
        redirect_to product_mypayjp_path(path)
      elsif path[:controller] == "users"
        redirect_to root_path
      end
    else
      redirect_to register_cregit_card_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  private
  def update_user_profile
    params.require(:user).permit(:image)
  end

end
