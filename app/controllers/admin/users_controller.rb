class Admin::UsersController < ApplicationController
  def index
    @users = User.all
    # @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path(@user)
    else
      redirect_to request.referer
      # render :edit
    end
  end
  
  # 退会フラグ
  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_users_path 
  end  
  
  #ストロングパラメーター
  def user_params
    params.require(:user).permit(:nickname, :email, :password, :user_image,:is_deleted)  
  end  
end
