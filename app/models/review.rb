class Review < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  belongs_to :park
end
