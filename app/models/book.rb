class Book < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :book_categories, dependent: :destroy

  has_many :authors, through: :book_authors
  has_many :categories, through: :book_categories
end
