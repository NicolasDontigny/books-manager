class MakeAmazonRatingDecimalForOnlineReview < ActiveRecord::Migration[5.2]
  def change
    change_column :online_reviews, :amazon_rating, :decimal
  end
end
