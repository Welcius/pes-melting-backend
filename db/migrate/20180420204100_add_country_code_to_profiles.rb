class AddCountryCodeToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :country_code, :string
  end
end
