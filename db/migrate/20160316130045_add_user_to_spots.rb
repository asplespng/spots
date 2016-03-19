class AddUserToSpots < ActiveRecord::Migration
  def change
    add_reference :spots, :user, index: true, foreign_key: true, null: false
  end
end
