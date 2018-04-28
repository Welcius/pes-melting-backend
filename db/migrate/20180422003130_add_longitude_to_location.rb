class AddLongitudeToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :longitude, :float
  end
end
