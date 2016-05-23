class CreateJoinTableSpaceAmenity < ActiveRecord::Migration[5.0]
  def change
    create_join_table :spaces, :amenities do |_t|
      # t.index [:space_id, :amenity_id]
      # t.index [:amenity_id, :space_id]
    end
  end
end
