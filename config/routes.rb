Rails.application.routes.draw do

  # namespace :public do
  #   get 'parks/index'
  #   get 'parks/show'
  #   get 'parks/edit'
  # end
  # namespace :admin do
  #   get 'parks/index'
  #   get 'parks/show'
  #   get 'parks/edit'
  # end
  
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
   
  #ゲストログイン 
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
 
  
  #会員用サイト
  scope module: :public do
    root to:'homes#top'
    ##User 
    get "users/my_page"=>"users#show",as:"user"
    get "users/information/edit"=>"users#edit",as:"info_edit"
    patch "users/information"=>"users#update",as:"info"
    get "users/confirm"=>"users#confirm"
    patch "users/withdraw"=>"users#withdraw" 
    
    
    resources :parks,only: [:index, :create, :show, :edit]do
      resources :reviews,only:[:create]
    end  
    # resources :users,only: [:show, :edit, :update]
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
    root to:'parks#index'
    # get 'users/index'
    # get 'users/show'
    # get 'users/edit'
    resources :users,only: [:index,:show, :update]
    
    resources :parks,only: [:index, :create, :show, :edit] do
      resources :reviews,only:[:create]
    end
    
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
