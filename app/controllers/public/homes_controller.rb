class Public::HomesController < ApplicationController
  def top
    @parks = Park.where(status:true).all
  end
end
