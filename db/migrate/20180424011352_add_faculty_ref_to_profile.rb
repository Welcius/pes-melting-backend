class AddFacultyRefToProfile < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :faculty, foreign_key: true
  end
end
