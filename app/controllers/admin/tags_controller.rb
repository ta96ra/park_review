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
  
  private
  
  def tag_params
    params.require(:tag).permit(:tag)
  end  
end
