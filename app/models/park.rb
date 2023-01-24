class Park < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :park_tag_relations, dependent: :destroy
  has_many :tags, through: :park_tag_relations, dependent: :destroy 
  ##parksテーブルから中間テーブルを介してtagsテーブルへの関連付け
  
  
  #バリデーション 
  validates :park, presence: true
  validates :address, presence: true
  
  #ジオコード
  geocoded_by :address
  after_validation :geocode
  
  # 公園ステータス
  ## stausがtrueならtrueを返すようにしている
  def active_for_authentication?
    # super && (status == false)
    super && (status == true)
  end
  
  #キーワード検索機能(部分一致)
  def self.search(keyword)
    where(["park like? AND detail like?", "%#{keyword}%", "%#{keyword}%"])
  end
  
  #ActionText
  has_rich_text :detail
  
  #ActiveStorage
  has_one_attached :park_image
  # has_many_attached :park_images
  
  ## 公園画像に関する処理---公園画像がない場合no_park_image.pngを使用
  def get_park_image(width, height)
    unless park_image.attached?
      file_path = Rails.root.join('app/assets/images/no_park_image.png')
      park_image.attach(io: File.open(file_path), filename: 'no_park_image.png', content_type: 'image/png')
    end
    park_image.variant(resize_to_limit: [width, height]).processed
  end
  
  ###複数画像に対応
  # def get_park_images(width, height)
  #   unless park_images.attached?
  #     file_path = Rails.root.join('app/assets/images/no_park_image.png')
  #     park_images.attach(io: File.open(file_path), filename: 'no_park_image.png', content_type: 'image/png')
  #   end
  #   park_images.variant(resize_to_limit: [width, height]).processed
  # end
  
  
  # GoogleMapAPI
  # after_validation :geocode
  
  # private
  # #住所からGoogleMapAPIにリクエストし緯度・経度を取得
  # def geocode
  #   query = URI.encode_www_form(address: self.address.gsub(" ", ""))
  #   uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?#{query}&key=#{ENV['API_KEY']}")
  #   res = Net::HTTP.get_response(uri)
  #   response = JSON.parse(res.body)
  #   self.latitude = response["results"][0]["geometry"]["location"]["lat"]
  #   self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  # end
  
    # 並べ替え機能
  # scope :latest, ->{order(created_at: :desc)}
  # scope :old, ->{order(create_at: :asc)}
  # scope :raty, -> {order(average_evaluation: :asc)}
  
end
