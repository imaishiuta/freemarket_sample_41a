class UsersController < ApplicationController
  protect_from_forgery except: :pay

  def index
    @user = User.find(1)
  end

  def register_cregit_card
  end

  def pay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    @user = User.find(current_user)
    @user.cardtoken = params[:cardtoken]
    if @user.save
      redirect_to root_path
    else
      redirect_to register_cregit_card_path
    end
  end

end
