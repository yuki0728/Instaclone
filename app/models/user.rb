class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  before_save   :downcase_email
  before_create :create_activation_digest

  before_save { self.email = email.downcase }
  
  # 名前のバリテーション
  validates :name, :user_name, presence: true, length: { maximum: 50 }
  
  # emailのバリテーション
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  # ウェブサイトのバリテーション
  validate :web_site, presence: true
  
  # プロフィールのバリテーション
  validate :profile, length: { maximum: 500 }
  
  # 電話番号のバリテーション
  validate :tel_number, length: { maximum: 500 }

  # 性別のバリテーション
  validate :sex, inclusion: { in: 1..3 }

  # パスワードのバリテーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  has_secure_password
  validates :password_confirmation, presence: true, length: { minimum: 6 }, allow_nil: true

  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email = email.downcase
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
