class CreateGardens < ActiveRecord::Migration
  def change
    create_table :gardens, id: :uuid do |t|
      t.string :name, limit: 255, null: false
      t.string :style, limit: 50, null: false
      t.float :width
      t.float :length
      t.float :depth
      t.float :hours_of_sun

      t.timestamps
    end
  end
end
