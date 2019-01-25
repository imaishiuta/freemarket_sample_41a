class CommentsController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :destroy]
  before_action :set_product


  def create
    @comment = @product.comments.new(params_comment)
    if @comment.save
      respond_to do |format|
        format.html {redirect_back(fallback_location: product_path(@product))}
        format.js
      end
    else
      redirect_back(fallback_location: product_path(@product))
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.html {redirect_back(fallback_location: product_path(@product))}
        format.js
      end
    else

      redirect_to product_path(@product)
    end

  end

  private
  def params_comment
    params.require(:comment).permit(:text).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

end
