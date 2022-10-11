class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy
  has_many :books, through: :book_tags, source: :book

  def self.search_books_for(content, method)
    if method == "perfect"
      tags = Tag.where("name LIKE ?", "#{content}")
    elsif method == "forward"
      tags = Tag.where("name LIKE ?", "#{content}%")
    elsif method == "backward"
      tags = Tag.where("name LIKE ?", "%#{content}")
    else
      tags = Tag.where("name LIKE ?", "%#{content}%")
    end

    return tags.inject(init = []){|result, tag| result + tag.books}

# ーーーーーeach文に書き換えーーーーーーーー
    # result = []
    # tags.each do |tag|
    #   result = result += tag.books
    # end

    # return result
# ーーーーーーーーーーーーーーーーーーーーー

  end
end
