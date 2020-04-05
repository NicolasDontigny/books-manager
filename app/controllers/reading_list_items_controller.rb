class ReadingListItemsController < ApplicationController
  before_action :set_book, only: %i[create ]
  before_action :set_reading_list_item, only: %i[destroy]

  def index
    @reading_list_items = policy_scope(ReadingListItem)
  end

  def create
    @reading_list_item = ReadingListItem.new(
      book: @book,
      user: current_user,
      priority: 1,
      read: false
    )

    authorize @reading_list_item

    @reading_list_item.save

    redirect_to books_path
  end

  def destroy
    if @reading_list_item
      authorize @reading_list_item

      @reading_list_item.destroy
    end

    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_reading_list_item
    set_book
    @reading_list_item = ReadingListItem.find_by book: @book, user: current_user
  end
end