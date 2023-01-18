class Admin::ParksController < ApplicationController
  def index
    @park = Park.new
    @parks = Park.all
    # @parks = Park.page(params[:page])  #ページネーション導入のため
    
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
  
  # 新規登録機能はなし
  # def create
  #   @park = Park.new(park_params)
  #   @park.user_id = current_user.id
  #   if @park.save
  #     flash[:park_notice] = "公園を新規登録しました"
  #     redirect_to parks_path
  #   else
  #     @parks = Park.all
  #     render 'admin/parks/index'
  #   end     
  # end  

  def show
  end

  def edit
    
  end
  
  #キーワード検索
  def search
    @parks = Park.search(params[:keyword])
    @keyword = params[:keyword]
    @park = Park.new
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
  end
end
