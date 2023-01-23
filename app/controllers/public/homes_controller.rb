class Public::HomesController < ApplicationController
  def top
    # @park = Park.find(params[:id])
    @parks = Park.where(status:true).all
    @sorts = Park.where(status:true).all.order(average_evaluation: "DESC")
  end
end
