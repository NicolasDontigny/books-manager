class CreateOnlineReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :online_reviews do |t|
      t.integer :amazon_rating
      t.integer :number_of_amazon_ratings
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
