class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new
    unless @book.view_counts.find_by(user_id: @user.id)
      @view_count = @book.view_counts.new(user_id: @user.id)
      @view_count.save
    end
  end

  def index
    @book = Book.new
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    # @books = Book.all.sort{|a,b|
    # b.favorites.where(created_at: from...to).size <=>
    # a.favorites.where(created_at: from...to).size
    # }
    @books = Book.all.order(params[:sort])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag_name].split(',')
    if @book.save
       @book.save_tags(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @tag_list = []
    @book.tags.each do |tag|
      @tag_list.append(tag.name)
    end
  end

  def update
    @book = Book.find(params[:id])
    tag_list = params[:book][:tag_name].split(',')
    if @book.update(book_params)
      @book.save_tags(tag_list)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
