class Admin::ReviewsController < ApplicationController
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
