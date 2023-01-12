class Admin::ParksController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end
  
  #ストロングパラメーター
  def park_params
    params.require(:park).permit(:user_id, :prefecture_id, :park, :address, :longitude, :latitude, :detail, :status, :average_evaluation)  
  end  
end
