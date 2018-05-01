class AddAddressToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :address, :string
  end
end
