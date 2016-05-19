class CreateSpaceTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :space_types do |t|
      t.string :name

      t.timestamps
    end

    add_index :space_types, :name, unique: true
  end
end
