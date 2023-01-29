class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def create
    @tag = Tag.new(tag_params)
    @tag.save
    render :tags
    # if @tag.save
    #   flash[:notice] = 'タグを登録しました'
    #   # redirect_to admin_parks_path  #同期通信用
    #   render :tags
    # else
    #   flash[:danger] = 'タグを登録に失敗しました'
    #   # redirect_to admin_parks_path #同期通信用
    #   render :error
    # end
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    # redirect_to admin_parks_path  #同期通信用
    render :tags  #非同期通信用
  end  
  
  private
  def tag_params
    params.permit(:tag)
  end  
end
