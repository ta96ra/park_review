class Public::ReviewsController < ApplicationController
  def create
    @park = Park.find(params[:park_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    # review = current_user.reviews.new(review_params)
    @review.park_id = @park.id
    if @review.save
      @park.update(average_evaluation: @park.reviews.average(:evaluation).round(1))
      redirect_to request.referer
    else
      render template: "public/parks/edit"
    end  
  end
  
  def destroy
    @park = Park.find(params[:park_id])
    Review.find(params[:id]).destroy
    @park.update(average_evaluation: @park.reviews.average(:evaluation).round(1))
    redirect_to request.referer
  end

  private
  #ストロングパラメーター
  def review_params
    params.require(:review).permit(:review, :evaluation)
  end
end
