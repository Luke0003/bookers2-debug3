class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags, source: :tag
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :created_today, -> {where(created_at: Time.current.all_day)}
  scope :created_yesterday, -> {where(created_at: 1.day.ago.all_day)}
  scope :created_2day_ago, -> {where(created_at: 2.day.ago.all_day)}
  scope :created_3day_ago, -> {where(created_at: 3.day.ago.all_day)}
  scope :created_4day_ago, -> {where(created_at: 4.day.ago.all_day)}
  scope :created_5day_ago, -> {where(created_at: 5.day.ago.all_day)}
  scope :created_6day_ago, -> {where(created_at: 6.day.ago.all_day)}

  scope :created_this_week, -> {where(created_at: 6.day.ago.at_beginning_of_day..Time.current.at_end_of_day)}
  scope :created_last_week, -> {where(created_at: 2.week.ago.at_beginning_of_day..1.week.ago.at_end_of_day)}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_tags(savebook_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savebook_tags
    new_tags = savebook_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      book_tag = Tag.find_or_create_by(name: new_name)
      self.tags << book_tag
    end
  end

  def self.search_for(content, method)
    if method == "perfect"
      Book.where("title LIKE?", "#{content}")
    elsif method == "forward"
      Book.where("title LIKE?", "#{content}%")
    elsif method == "backward"
      Book.where("title LIKE?", "%#{content}")
    elsif method == "partial"
      Book.where("title LIKE?", "%#{content}%")
    else
      Book.all
    end
  end
end