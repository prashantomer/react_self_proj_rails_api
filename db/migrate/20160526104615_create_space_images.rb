class CreateSpaceImages < ActiveRecord::Migration[5.0]
  def change
    create_table :space_images do |t|
      t.string :image
      t.references :space, foreign_key: true

      t.timestamps
    end
  end
end
