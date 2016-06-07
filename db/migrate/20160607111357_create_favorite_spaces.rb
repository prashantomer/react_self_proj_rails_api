class CreateFavoriteSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_spaces do |t|
      t.references :space, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
