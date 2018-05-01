class AddAvatarRefToProfile < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :avatar, foreign_key: true
  end
end
