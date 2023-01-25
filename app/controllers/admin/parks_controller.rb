class Admin::ParksController < ApplicationController
  before_action :authenticate_admin!
  def index
    @park = Park.new
    @parks = Park.all
    # @parks = Park.page(params[:page])  #ページネーション導入のため
    
    # タグのOR検索
    if params[:tag_ids]
      @parks = []
      params[:tag_ids].each do |key, value|      
        @parks += Tag.find_by(tag: key).parks if value == "1"
      end
      @parks.uniq!
      #uniq = 重複を取り除く
    end 
    # タグの追加
    @tag = Tag.new
    
    # タグの複数検索(2つのみ)
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

  def show
    @park = Park.find(params[:id])
    # @parks = Park.all
    @reviews = Review.all
  end

  def edit
    @park = Park.find(params[:id])
    @review = Review.new
  end
  
  def update
    @park = Park.find(params[:id])
    if @park.update(park_params)
      flash[:notice] = "公園情報を更新しました"
      redirect_to admin_park_path(@park.id)
      
      # 公園の表示設定のフラッシュメッセージ（不要かも）
      # if params[:park][:status] == "false"
      #   flash[:notice] = "公園非表示に設定いたしました"
      # else
      #   flash[:notice] = "公園表示を有効にしました"
      # end
      
    else
      render "admin/parks/edit"
    end
  end
  
  #キーワード検索
  def search
    @parks = Park.search(params[:keyword])
    @keyword = params[:keyword]
    @park = Park.new
    @tag = Tag.new
    render "admin/parks/index"   
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
    render "admin/parks/index"
    #ページネーション導入時の記述
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
    # params.require(:tag).permit(:tag)
  end
end
