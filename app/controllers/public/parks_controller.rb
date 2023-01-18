class Public::ParksController < ApplicationController
  def index
    @park = Park.new
    @parks = Park.all
    # @parks = Park.page(params[:page])  #ページネーション導入のため
    
    # タグのAND検索
    #ページネーションのため記述変更が必要
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
    # @average_evaluation = Review.group(:review_id).average(:evaluation)
    
    
    # タグの追加(管理者のみに制限するため、後ほど削除)
    if params[:tag]
      Tag.create(tag: params[:tag])
    end
  end
  
  def update
    @park = Park.find(params[:id])
    if @park.update(park_params)
      flash[:park_notice] = "公園情報を更新しました"
      redirect_to park_path(@park.id)
    else
      render :edit
    end
    
  end
  
  #キーワード検索
  def search
    @parks = Park.search(params[:keyword])
    @keyword = params[:keyword]
    @park = Park.new
    render "index" 
    #ページネーション導入の場合、記述変更が必要
  end
  
  #並べ替え
  def sort
    if params[:new]
      @parks = Park.all.order(id: "DESC")
    elsif params[:old]
      @parks = Park.all.order(id: "ASC")
    elsif params[:raty]
      @parks = Park.all.order(average_evaluation: "DESC")
    end  
    
    @park = Park.new
    render "index"
    #ページネーション導入の場合、記述変更が必要
    # if params[:new]
    #   @parks = Park.page(params[:page]).order(id: "DESC")
    # elsif params[:old]
    #   @parks = Park.page(params[:page]).order(id: "ASC")
    # elsif params[:raty]
    #   @parks = Park.page(params[:page]).order(average_evaluation: "DESC")
    # end  
  end
  
  private
  #ストロングパラメーター
  def park_params
    params.require(:park).permit(:user_id, :prefecture_id, :park, :address, :longitude, :latitude, :detail, :status, :average_evaluation, :park_image, tag_ids: [])  
  end
  
  ##複数画像に対応
  # def park_params
  #   params.require(:park).permit(:user_id, :prefecture_id, :park, :address, :longitude, :latitude, :detail, :status, :average_evaluation, :park_images[], tag_ids: [])  
  # end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
