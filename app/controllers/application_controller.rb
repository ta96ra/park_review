class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

 #アクセス制限にかかれば新規登録画面へ
  def authenticate_user
    if @current_user==nil
      flash[:login_notice]="ログインが必要です"
    end
  end
# def autheniticate_admin
#   if @current_admin==nil
#     flash[:notice]="ログインが必要です"
#     redirect_to new_user_registration_path  
#   end
# end

# ログアウト後の遷移
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      root_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end  
  end


  protected

  #diviseのストロングパラメーター
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
