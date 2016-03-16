class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.float :latitude
      t.float :longitude
      t.float :radius

      t.timestamps null: false
    end
  end
end
