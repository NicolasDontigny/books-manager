module ApplicationHelper
  def print_authors(book)
    return '' if book.authors.empty?

    authors = 'by '

    book.authors.each_with_index do |author, index|
      authors += "#{author.first_name} #{author.last_name}"

      if index == book.authors.length - 2
        authors += ' and '
      elsif index != book.authors.length - 1
        authors += ', '
      end
    end

    authors
  end
end
