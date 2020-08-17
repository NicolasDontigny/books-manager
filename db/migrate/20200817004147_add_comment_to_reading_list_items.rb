class AddCommentToReadingListItems < ActiveRecord::Migration[5.2]
  def change
    add_column :reading_list_items, :comment, :text
  end
end
