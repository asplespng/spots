class AddNameToSpots < ActiveRecord::Migration

  def change
    add_column :spots, :name, :string, null: false
  end
end
