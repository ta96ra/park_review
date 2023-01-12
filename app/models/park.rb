class Park < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  has_many :reviews
  
  
  #ActiveStorage
  has_one_attached :park_image
   # has_many_attached :park_image
  
  
  #バリデーション 
  validates :park, presence: true
  validates :address, presence: true
  
end
