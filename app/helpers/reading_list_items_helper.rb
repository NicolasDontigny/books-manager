module ReadingListItemsHelper
  def book_in_reading_list(book)
    book.users.include?(current_user)
  end

  def book_is_read(book)
    reading_list_item = ReadingListItem
                        .where(book: book)
                        .find_by(user: current_user)

    reading_list_item&.read
  end
end
