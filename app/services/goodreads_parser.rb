require 'open-uri'
require 'nokogiri'

class GoodreadsParser
  def initialize(url)
    @url = url
  end

  def execute
    html_file = open(@url).read
    @html_doc = Nokogiri::HTML(html_file)

    set_title
    set_publishing_date
    set_rating
    set_number_of_reviews
    set_authors
    set_description
    set_cover_url

    @book = Book.new(
      title: @title,
      description: @description,
      year_published: @publishing_date,
      cover_url: @cover_url,
      authors: @authors
    )

    @book.online_review = OnlineReview.create(
      goodread_rating: @rating,
      number_of_goodread_ratings: @number_of_reviews
    )

    @book
  end

  private

  def set_title
    @title = @html_doc.at('h1#bookTitle').text.strip
  end

  def set_publishing_date
    @publishing_date = nil
    @html_doc.search('#details .row').each do |element|
      next unless element.text.strip.match?('Published')

      year_pattern = /Published(\\n)?\s*[a-zA-Z]+\s\d{1,2}[a-zA-Z]{1,2}\s(?<year>\d{4}(\\n)?\s*by)/
      match_data = element.text.strip.match(year_pattern)
      @publishing_date = match_data.nil? ? nil : match_data[:year].to_i
    end
  end

  def set_rating
    rating_element = @html_doc.at('#bookMeta [itemprop="ratingValue"]')
    return unless rating_element

    @rating = rating_element.text.strip.to_f
  end

  def set_number_of_reviews
    number_of_reviews_element = @html_doc.at('#bookMeta [itemprop="ratingCount"]')
    return unless number_of_reviews_element

    @number_of_reviews = number_of_reviews_element
                         .attribute('content').value.to_i
  end

  def set_authors
    @authors = []
    @html_doc.search('#bookAuthors .authorName__container').each do |element|
      names = element.at('[itemprop="name"]').text.strip.split(/\s/)
      next unless names

      if names.count > 2
        first_name = names.shift
        last_name = names.join(' ')
      else
        first_name = names[0] || ''
        last_name = names[1] || ''
      end

      existing_author = Author
                        .find_by(first_name: first_name, last_name: last_name)
      author = existing_author ||
               Author.create(first_name: first_name, last_name: last_name)
      @authors << author
    end
  end

  def set_description
    @description = @html_doc.at('#description span:nth-child(2)')&.inner_html
  end

  def set_cover_url
    @cover_url = @html_doc.at('#coverImage')&.attribute('src')&.value
  end
end
