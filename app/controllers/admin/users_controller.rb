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
      # 会員ステータスによりファラッシュメッセージを変える
      if params[:user][:is_deleted] == "true"
        flash[:notice] = "退会処理を実行いたしました"
        redirect_to admin_users_path(@user)
      else
        flash[:notice] = "会員を有効にしました"
        redirect_to admin_users_path(@user)
      end
      
    else
      redirect_to request.referer
    end
  end
  
  private
  #ストロングパラメーター
  def user_params
    params.require(:user).permit(:nickname, :email, :password, :user_image,:is_deleted)  
  end  
end
