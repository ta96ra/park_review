class Public::UsersController < ApplicationController
  # アクセス制限
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit,:confirm]
  
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
  
  
  private
  #ストロングパラメーター
  def user_params
    params.require(:user).permit(:nickname, :email, :password, :user_image, :is_deleted)  
  end  
  
  def ensure_guest_user
    @user = current_user
    if @user.nickname == "guestuser"
      flash[:notice] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      redirect_to user_path(current_user) 
    end
  end  
end
