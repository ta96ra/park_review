class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = 'タグを登録しました'
      redirect_to admin_parks_path
    else
      flash[:danger] = 'タグを登録に失敗しました'
      redirect_to admin_parks_path
    end
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    # Tag.find(params[:id]).destroy
    redirect_to admin_parks_path
  end  
  
  private
  def tag_params
    params.permit(:tag)
  end  
end
