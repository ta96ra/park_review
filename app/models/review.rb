class Review < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  belongs_to :park
  
  #バリデーション 
  validates :review, presence: true
end
