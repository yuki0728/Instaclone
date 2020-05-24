class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  attr_accessor :activation_token

  before_save   :downcase_email
  before_create :create_activation_digest
  before_save { self.email = email.downcase }

  mount_uploader :image, ImageUploader

  # 名前のバリテーション
  validates :name, :user_name, presence: true, length: { maximum: 50 }

  # emailのバリテーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # プロフィールのバリテーション
  validates :profile, length: { maximum: 500 }

  # 電話番号のバリテーション
  validates :tel_number, length: { maximum: 500 }

  # パスワードのバリテーション
  has_secure_password
  validates :password_confirmation, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email = email.downcase
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = SecureRandom.urlsafe_base64
    self.activation_digest = User.digest(activation_token)
  end
end
