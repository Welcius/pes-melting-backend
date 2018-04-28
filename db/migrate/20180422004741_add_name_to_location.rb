class AddNameToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :name, :string
  end
end
