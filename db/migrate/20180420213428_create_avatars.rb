class CreateAvatars < ActiveRecord::Migration[5.1]
  def change
    create_table :avatars do |t|
      t.references :profile, foreign_key: true
      t.string :image_data

      t.timestamps
    end
  end
end
