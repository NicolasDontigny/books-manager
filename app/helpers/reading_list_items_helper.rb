module ReadingListItemsHelper
  def book_in_reading_list(book)
    book.users.include?(current_user)
  end
end
