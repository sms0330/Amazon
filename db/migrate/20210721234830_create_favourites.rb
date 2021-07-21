class CreateFavourites < ActiveRecord::Migration[6.1]
  def change
    create_table :favourites do |t|
      t.boolean :is_favourite
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
    end
  end
end
