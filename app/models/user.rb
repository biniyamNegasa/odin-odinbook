class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_many :likes, through: :posts


  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 27 }
end
