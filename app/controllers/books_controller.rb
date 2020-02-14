class BooksController < ApplicationController
  before_action :skip_pundit?, only: [:show]
  before_action :set_book, only: %i[show]

  def index
    @books = policy_scope(Book)
  end

  def show
  end

  def new
    @book = Book.new
    @authors = Author.all
    @categories = Category.all
  end

  def create
    book = Book.new(book_params)

    author_ids = params[:book][:authors]

    book.authors.push(Author.find(author_ids))

    book.save

    raise
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :subtitle, :description, :year_published, :fiction)
  end
end
