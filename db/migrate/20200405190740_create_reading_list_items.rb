class CreateReadingListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :reading_list_items do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :priority
      t.boolean :read

      t.timestamps
    end
  end
end
