class AddStateToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :state, :string
  end
end
