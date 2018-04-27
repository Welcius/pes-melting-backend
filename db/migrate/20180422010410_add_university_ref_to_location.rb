class AddUniversityRefToLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :university, foreign_key => { :to_table => :locations }
  end
end
