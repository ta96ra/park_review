class Public::ParksController < ApplicationController
  before_action :authenticate_user!, {only: [:create,:edit, :update]}
  def index
    @park = Park.new
    @parks = Park.where(status:true).all  # 公園ステータスがtrueのみ表示
    # @parks = Park.page(params[:page])  #ページネーション導入のため
    
    # タグのOR検索
    if params[:tag_ids]
      @parks = []
      params[:tag_ids].each do |key, value|      
        @parks += Tag.find_by(tag: key).parks if value == "1"
      end
      @parks.uniq!  #uniq = 重複を取り除く
    end 
    # タグの複数検索(2つのみX)
    # if params[:tag_ids]
    #   @parks = []
    #   params[:tag_ids].each do |key, value|
    #     if value == "1"
    #       tag_parks = Tag.find_by(tag: key).parks
    #       @parks = @parks.empty? ? tag_parks : @parks & tag_parks
    #     end
    #   end
    # end 
  end
  
  def create
    @park = Park.new(park_params)
    @park.user_id = current_user.id
    if @park.save
      flash[:notice] = "公園を新規登録しました"
      redirect_to parks_path
    else
      @parks = Park.where(status:true).all
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
  end
  
  def update
    @park = Park.find(params[:id])
    if @park.update(park_params)
      flash[:notice] = "公園情報を更新しました"
      redirect_to park_path(@park.id)
    else
      @review = Review.new
      render :edit
    end
  end
  
  #キーワード検索
  def search
    @parks = Park.where(status:true).search(params[:keyword])
    @keyword = params[:keyword]
    @park = Park.new
    render "index" 
    #ページネーション導入の場合、記述変更が必要
  end
  
  #並べ替え
  def sort
    if params[:new]
      @parks = Park.where(status:true).all.order(created_at: "DESC")
    elsif params[:old]
      @parks = Park.where(status:true).all.order(created_at: "ASC")
    elsif params[:raty]
      @parks = Park.where(status:true).all.order(average_evaluation: "DESC")
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
  
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
