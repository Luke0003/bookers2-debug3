class SearchesController < ApplicationController

  def search
    @content = params[:content]
    @model = params[:model]
    @method = params[:method]

    if @model == "User"
      @users = User.search_for(@content, @method)
    elsif @model == "Book"
      @records = Book.search_for(@content, @method)
    elsif @model == "Tag"
      @records = Tag.search_books_for(@content, @method)
    end
  end

end
