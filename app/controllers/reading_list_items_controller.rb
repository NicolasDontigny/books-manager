class ReadingListItemsController < ApplicationController
  before_action :set_book, only: %i[create]
  before_action :set_reading_list_item, only: %i[destroy mark_as_read mark_as_unread]

  def index
    @reading_list_items = policy_scope(ReadingListItem).where(read: false)

    @items_next = @reading_list_items.where(priority: 'next')
    @items_soon = @reading_list_items.where(priority: 'soon')
    @items_interested = @reading_list_items.where(priority: 'interested')
  end

  def read_books
    @read_books = policy_scope(ReadingListItem).where(read: true)

    authorize @read_books
  end

  def create
    @reading_list_item = ReadingListItem.new(
      book: @book,
      user: current_user,
      priority: params[:priority].to_i,
      read: false
    )

    authorize @reading_list_item

    @reading_list_item.save

    redirect_to books_path
  end

  def update
    @book = Book.find(params[:book_id])
    @reading_list_item = ReadingListItem
                         .where(user: current_user)
                         .find_by(book: @book)

    @reading_list_item.priority = params[:priority].to_i
    authorize @reading_list_item

    @reading_list_item.save
  end

  def destroy
    if @reading_list_item
      authorize @reading_list_item

      @reading_list_item.destroy
    end

    redirect_to books_path
  end

  def mark_as_read
    if @reading_list_item.nil?
      @reading_list_item = ReadingListItem.new(
        book: @book,
        user: current_user,
        read: true
      )
    else
      @reading_list_item.read = true
    end

    authorize @reading_list_item

    @reading_list_item.save

    redirect_to books_path
  end

  def mark_as_unread
    redirect_to books_path if @reading_list_item.nil?

    authorize @reading_list_item

    @reading_list_item.read = false
    @reading_list_item.save

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
