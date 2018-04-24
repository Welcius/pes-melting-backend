class AddUniversityRefToLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :university, foreign_key: true
  end
end
