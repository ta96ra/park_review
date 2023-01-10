Rails.application.routes.draw do

  #------------------
  # 会員用
  #------------------
 
  #会員用(新規登録、ログイン)
  # URL /users/sign_in ...
  devise_for :users, skip:[:passwords],controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'  
  }
  ##skip:[:不要なルーティング]
  
  #会員用サイト
  scope module: :public do
    root to:'homes#top'
    get 'users/show'
    get 'users/edit'
  end  
  
  
  #------------------
  # 管理者用
  #------------------
  
  #管理者用(ログイン)
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations,:passwords],controllers:{
    sessions: "admin/sessions"
  }
  
  #管理者用サイト
  namespace :admin do
    root to:'users#index'
    # get 'users/index'
    get 'users/show'
    get 'users/edit'
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
