class AddFacultyRefToProfile < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :faculty, foreign_key: { to_table: :locations }, index: true
  end
end
