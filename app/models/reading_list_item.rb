class ReadingListItem < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum priority: %i[next soon interested]

  validates_uniqueness_of :book_id, scope: [:user_id]
end
