class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites
  has_many :book_comments, dependent: :destroy
  has_many :relationships, foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :relationships, source: "follower"
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: "following"
  has_many :user_rooms
  has_many :chats
  has_many :view_counts, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def followed_by?(user)
    reverse_of_relationships.exists?(following_id: user.id)
  end

  def self.search_for(content, method)
    if method == "perfect"
      User.where("name LIKE?", "#{content}")
    elsif method == "forward"
      User.where("name LIKE?", "#{content}%")
    elsif method == "backward"
      User.where("name LIKE?", "%#{content}")
    elsif method == "partial"
      User.where("name LIKE?", "%#{content}%")
    else
      User.all
    end
  end
end
