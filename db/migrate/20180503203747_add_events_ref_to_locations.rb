class AddEventsRefToLocations < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :event, foreign_key: true
  end
end
