class AddLocationRefToEvent < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :location, foreign_key: true
  end
end
