# require 'pry-byebug'
require_relative '../services/amazon_parser'
require_relative '../services/goodreads_parser'

# frozen_string_literal: true

# Top-level comment
class BooksController < ApplicationController
  before_action :skip_pundit?, only: [:show]
  before_action :set_book, only: %i[show edit update destroy]

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

    assign_authors
    assign_new_authors
    assign_categories
    assign_new_categories
    assign_online_reviews

    @book.created_by = current_user

    authorize @book

    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def create_from_website
    website = params[:website]
    @url = params[:url]

    if website == 'goodreads'
      @book = GoodreadsParser.new(@url).execute
    elsif website == 'amazon'
      @book = AmazonParser.new(@url).execute
    end

    @book.created_by = current_user

    assign_categories
    assign_new_categories

    authorize @book

    if @book.save
      redirect_to books_path
    else
      @authors = Author.all
      @categories = Category.all
      render :new
    end
  end

  def edit
    @authors = Author.all
    @categories = Category.all

    authorize @book
  end

  def update
    authorize @book

    @book.update(book_params)

    assign_authors
    assign_new_authors
    assign_categories
    assign_new_categories
    assign_online_reviews

    if @book.save
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    authorize @book

    @book.destroy

    redirect_to books_path
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

  def online_reviews_params
    params.require(:online_reviews).permit(
      :amazon_rating,
      :number_of_amazon_ratings,
    )
  end

  def assign_online_reviews
    online_reviews = OnlineReview.create(online_reviews_params)
    @book.online_review = online_reviews
  end

  def assign_new_authors
    authors = params[:book][:new_authors]
    return unless authors

    authors.each do |author|
      created_author = Author.create(
        first_name: author[:first_name],
        last_name: author[:last_name],
      )
      @book.authors.push(created_author) if created_author
    end
  end

  def assign_new_categories
    categories = params[:book][:new_categories]
    return unless categories

    categories.each do |category|
      created_category = Category.create(
        name: category[:name],
      )
      @book.categories.push(created_category) if created_category
    end
  end

  def assign_authors
    author_ids = params[:book][:authors]
    return unless author_ids

    @book.authors = []

    author_ids.each do |author_id|
      author = Author.find(author_id)
      @book.authors.push(author) if author
    end
  end

  def assign_categories
    category_ids = params[:book][:categories]
    return unless category_ids

    @book.categories = []

    category_ids.each do |category_id|
      category = Category.find(category_id)
      @book.categories.push(category) if category
    end
  end
end
