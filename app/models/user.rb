class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [ :github ]

  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_many :likes, through: :posts

  has_many :follower_follows, class_name: "Follow", foreign_key: :followee_id
  has_many :followers, through: :follower_follows, source: :follower

  has_many :followee_follows, class_name: "Follow", foreign_key: :follower_id
  has_many :followees, through: :followee_follows, source: :followee

  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 27 }

  after_create_commit :send_welcome_email

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email.presence || "user-#{auth.uid}@example.com" # Fallback email
      user.username = auth.info.nickname.presence || "github_user_#{auth.uid}" # Fallback username
      user.password ||= Devise.friendly_token[0, 20] # Avoid overriding existing passwords
    end
  end

  def following?(user)
    followees.include?(user)
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end
