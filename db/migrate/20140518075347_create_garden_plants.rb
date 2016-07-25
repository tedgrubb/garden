class CreateGardenPlants < ActiveRecord::Migration
  def change
    create_table :garden_plants, id: :uuid do |t|
      t.uuid :plant_id
      t.uuid :garden_id
      t.integer :x_pos
      t.integer :y_pos
      t.string :state
      t.datetime :harvested_at

      t.timestamps
    end
  end
end
