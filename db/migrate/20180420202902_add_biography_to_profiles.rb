class AddBiographyToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :biography, :text
  end
end
