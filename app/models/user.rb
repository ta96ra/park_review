class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, #パスワードの正確性を検証
        :registerable, #ユーザー登録や編集、削除
        :recoverable, #パスワードのリセット
        :rememberable, #ログイン情報を保存
        :validatable #emailのフォーマットなどのバリデーション
        
  #ゲストログイン
  def self.guest
    find_or_create_by!(nickname: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.nickname = "guestuser"
      user.email = "guest@example.com"
    end
  end
        
  
  #アソシエーション
  has_many:parks
  has_many:reviews,dependent: :destroy
  
  #ActiveStorage
  has_one_attached :user_image
  
   # 会員画像に関する処理---会員画像がない場合no_image.jpgを使用
  def get_user_image(width, height)
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    user_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #バリデーション 
  validates :nickname, presence: true
  validates :email, presence: true
  
  # 退会処理
  ## is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
end
