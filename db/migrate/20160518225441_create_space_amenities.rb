class CreateSpaceAmenities < ActiveRecord::Migration[5.0]
  def change
    create_table :space_amenities do |t|
      t.references :space, foreign_key: true
      t.references :amenity, foreign_key: true

      t.timestamps
    end
  end
end
