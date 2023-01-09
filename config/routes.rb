Rails.application.routes.draw do
 
  #会員用(新規登録、ログイン)
  # URL /customers/sign_in ...
  devise_for :users, skip:[:passwords],controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'  
  }
  #*skip:[:不要なルーティング]
  
  
  #管理者用(ログイン)
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations,:passwords],controllers:{
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
