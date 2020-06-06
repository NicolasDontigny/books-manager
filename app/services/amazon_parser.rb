require 'open-uri'
require 'nokogiri'

class AmazonParser
  def initialize(url)
    @url = url
  end

  def execute
    html_file = open(@url,
      "User-Agent" => "Ruby/#{RUBY_VERSION}",
      "From" => "nicolas.dontigny1@gmail.com",
      "Referer" => "http://www.ruby-lang.org/").read
    html_doc = Nokogiri::HTML(html_file)

    @title = html_doc.at('h1#title #productTitle').text.strip

    @publishing_date = nil
    html_doc.search('#productDetailsTable .bucket .content li').each do |element|
      if element.search('b').text.strip == 'Publisher:'
        match_data = element.text.strip.match(/\([a-zA-Z]*\.?\s\d{1,2}\s(?<year>\d{4})\)/)
        @publishing_date = match_data[:year]
      end
    end

    rating_element = html_doc.at('#arcPopover .a-declarative .a-icon-star a-icon-alt')
    rating_match_data = rating_element.text.strip.match(/(?<rating>\d\.?\d?) out of 5 stars/)
    @rating = rating_match_data[:rating]

    number_of_reviews_element = html_doc.at('#acrCustomerReviewLink #acrCustomerReviewText')
    number_of_reviews_pattern = /(?<number>\d?,\d{0,3},?\d{0,3}) ratings/
    number_of_reviews_match_data = number_of_reviews_element.text.strip.match(number_of_reviews_pattern)
    @number_of_reviews = number_of_reviews_match_data[:number].tr(',', '').to_i

    @authors = []
    html_doc.search('#bylineInfo .author').each do |element|
      names = element.text.strip.split(/\s/)
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

    raise
  end
end
