class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
      t.references :user, foreign_key: true
      t.references :space_type, foreign_key: true
      t.string :title
      t.string :slug
      t.text   :description
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :country
      t.string :latitude
      t.string :longitude
      t.decimal :capacity

      t.timestamps
    end
  end
end
