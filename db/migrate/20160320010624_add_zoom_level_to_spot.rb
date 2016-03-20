class AddZoomLevelToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :zoom_level, :integer, null: false, default: 10
  end
end
