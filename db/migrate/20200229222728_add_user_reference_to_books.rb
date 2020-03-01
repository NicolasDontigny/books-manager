class AddUserReferenceToBooks < ActiveRecord::Migration[5.2]
  def change
    add_reference :books, :created_by, index: true
    add_foreign_key :books, :users, column: :created_by_id
  end
end
