class AddAddressToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :address_1, :string
    add_column :spots, :address_2, :string
    add_column :spots, :city, :string
    add_column :spots, :zip, :integer
  end
end
