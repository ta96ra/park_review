class Public::ReviewsController < ApplicationController
  def create
    park = Park.find(params[:park_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    # review = current_user.reviews.new(review_params)
    @review.park_id = park.id
    if @review.save
      redirect_to request.referer
    else
      # 要修正
      redirect_to request.referer
      # render template: "park/edit"
    end  
  end
  
  def destroy
    Review.find(params[:id]).destroy
    redirect_to request.referer
    # redirect_to post_image_path(params[:post_image_id])
  end

  private
  #ストロングパラメーター
  def review_params
    params.require(:review).permit(:review)
  end
end
