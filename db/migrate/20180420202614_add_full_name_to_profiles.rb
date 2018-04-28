class AddFullNameToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :full_name, :string
  end
end
