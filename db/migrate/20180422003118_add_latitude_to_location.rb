class AddLatitudeToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :latitude, :float
  end
end
