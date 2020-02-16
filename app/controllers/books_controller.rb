class BooksController < ApplicationController
  before_action :skip_pundit?, only: [:show]
  before_action :set_book, only: %i[show]

  def index
    @books = policy_scope(Book)
  end

  def show; end

  def new
    @book = Book.new
    @authors = Author.all
    @categories = Category.all
  end

  def create
    @book = Book.new(book_params)

    author_ids = params[:book][:authors]
    author_ids.each do |author_id|
      author = Author.find(author_id)
      @book.authors.push(author) if author
    end

    assign_categories

    authorize @book

    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(
      :title,
      :subtitle,
      :description,
      :year_published,
      :fiction,
      :cover_photo
    )
  end

  def assign_categories
    category_ids = params[:book][:categories]
    category_ids.each do |category_id|
      category = Category.find(category_id)
      @book.categories.push(category) if category
    end
  end
end
