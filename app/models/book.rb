class Book < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :book_categories, dependent: :destroy

  has_many :authors, through: :book_authors
  has_many :categories, through: :book_categories

  has_one :online_review, dependent: :destroy

  belongs_to :created_by, class_name: 'User'

  has_one_attached :cover_photo

  accepts_nested_attributes_for :authors
end
