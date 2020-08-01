require 'open-uri'
require 'nokogiri'

class GoodreadsParser
  def initialize(url)
    @url = url
  end

  def execute
    html_file = open(@url).read
    html_doc = Nokogiri::HTML(html_file)

    @title = html_doc.at('h1#bookTitle').text.strip

    @publishing_date = nil
    html_doc.search('#details .row').each do |element|
      if element.text.strip.match?('Published')
        # year_pattern = /Published(\\n)?\s*[a-zA-Z]+\s\d{1,2}[a-zA-Z]{1,2}\s(?<year>\d{4}(\\n)?\s*by)/
        match_data = element.text.strip.match(/Published(\\n)?\s*[a-zA-Z]+\s\d{1,2}[a-zA-Z]{1,2}\s(?<year>\d{4}(\\n)?\s*by)/)
        @publishing_date = match_data.nil? ? nil : match_data[:year].to_i
      end
    end

    rating_element = html_doc.at('#bookMeta [itemprop="ratingValue"]')
    rating_float = rating_element.text.strip.to_f
    @rating = (rating_float * 2).round / 2.0

    number_of_reviews_element = html_doc.at('#bookMeta [itemprop="ratingCount"]')
    @number_of_reviews = number_of_reviews_element.attribute("content").value.to_i

    @authors = []
    html_doc.search('#bookAuthors .authorName__container').each do |element|
      names = element.at('[itemprop="name"]').text.strip.split(/\s/)
      if names.count > 2
        first_name = names.shift
        last_name = names.join(' ')
      else
        first_name = names[0] || ''
        last_name = names[1] || ''
      end

      existing_author = Author.find_by(first_name: first_name, last_name: last_name)
      author = existing_author || Author.create(first_name: first_name, last_name: last_name)
      @authors << author
    end

    @description = html_doc.at('#description span:nth-child(2)').inner_html

    @cover_url = html_doc.at('#coverImage').attribute('src').value

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
end