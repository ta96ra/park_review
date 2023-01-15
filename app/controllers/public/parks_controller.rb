class Public::ParksController < ApplicationController
  def index
    @park = Park.new
    @parks = Park.all
    # @parks_part = @parks.page(params[:page])  #ページネーション導入のため
    
    # タグのAND検索
    if params[:tag_ids]
      @parks = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_parks = Tag.find_by(tag: key).parks
          @parks = @parks.empty? ? tag_parks : @tweets & tag_parks
        end
      end
    end 
  end
  
  def create
    @park = Park.new(park_params)
    @park.user_id = current_user.id
    if @park.save
      flash[:park_notice] = "公園を新規登録しました"
      redirect_to parks_path
    else
      @parks = Park.all
      render :index
    end     
  end  

  def show
    @park = Park.find(params[:id])
    # @reviews = Review.all
    
  end

  def edit
    @park = Park.find(params[:id])
    @review = Review.new
    @average_evaluastion = Review.group(:park_id).average(:evaluation)
  end
  
  def update
    @park = Park.find(params[:id])
    @park.update(park_params)
    redirect_to park_path
  end
  
  #キーワード検索
  def search
    @parks = Park.search(params[:keyword])
    @keyword = params[:keyword]
    @park = Park.new
    render "index"
    
end
  
  private
  #ストロングパラメーター
  def park_params
    params.require(:park).permit(:user_id, :prefecture_id, :park, :address, :longitude, :latitude, :detail, :status, :average_evaluation, :park_image, tag_ids: [])  
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
