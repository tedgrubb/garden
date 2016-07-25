class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants, id: :uuid do |t|
      t.string :name, limit: 255
      t.integer :days_to_harvest

      t.timestamps
    end
  end
end
