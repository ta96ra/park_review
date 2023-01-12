class Public::UsersController < ApplicationController
  
  def show
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:user_notice] = "会員情報を更新しました"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  #退会確認画面
  def confirm
    @user = current_user
  end
  #退会処理
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。またのご利用をお待ちしております。"
    redirect_to root_path
  end  
  
  def user_params
    params.require(:user).permit(:nickname, :email, :password, :user_image, :is_deleted)  
  end  
end
