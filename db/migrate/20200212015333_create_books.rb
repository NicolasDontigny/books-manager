class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.integer :year_published
      t.boolean :fiction, default: false

      t.timestamps
    end
  end
end
