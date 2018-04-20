class AddKarmaToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :karma, :integer
  end
end
