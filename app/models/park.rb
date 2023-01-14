class Park < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :park_tag_relations, dependent: :destroy
  has_many :tags, through: :park_tag_relations, dependent: :destroy 
  ##parksテーブルから中間テーブルを介してtagsテーブルへの関連付け
  
  
  #ActiveStorage
  has_one_attached :park_image
  # has_many_attached :park_image
  
  #ActionText
  has_rich_text :detail
    
   # 公園画像に関する処理---公園画像がない場合no_park_image.pngを使用
  def get_park_image(width, height)
    unless park_image.attached?
      file_path = Rails.root.join('app/assets/images/no_park_image.png')
      park_image.attach(io: File.open(file_path), filename: 'no_park_image.png', content_type: 'image/png')
    end
    park_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #バリデーション 
  validates :park, presence: true
  validates :address, presence: true
  
end
