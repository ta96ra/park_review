class Tag < ApplicationRecord
  
  #アソシエーション
  has_many :park_tag_relations, dependent: :destroy
  has_many :parks, through: :park_tag_relations, dependent: :destroy
  ##tagksテーブルから中間テーブルを介してparkssテーブルへの関連付け
end
