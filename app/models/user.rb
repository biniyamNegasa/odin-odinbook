class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_many :likes, through: :posts

  has_many :follower_follows, class_name: "Follow", foreign_key: :followee_id
  has_many :followers, through: :follower_follows, source: :follower

  has_many :followee_follows, class_name: "Follow", foreign_key: :follower_id
  has_many :followees, through: :followee_follows, source: :followee

  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 27 }

  def following?(user)
    followees.include?(user)
  end
end
