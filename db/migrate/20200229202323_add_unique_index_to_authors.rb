class AddUniqueIndexToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_index :authors, [:first_name, :last_name], unique: true
  end
end
