class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, #パスワードの正確性を検証
        :registerable, #ユーザー登録や編集、削除
        :recoverable, #パスワードのリセット
        :rememberable, #ログイン情報を保存
        :validatable #emailのフォーマットなどのバリデーション
end
