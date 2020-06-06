class AddGoodreadRatingsToOnlineReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :online_reviews, :goodread_rating, :decimal
    add_column :online_reviews, :number_of_goodread_ratings, :integer
  end
end
