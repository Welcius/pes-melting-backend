class Location < ApplicationRecord
    validates :latitude, presence: { message: "Latitude must be present" }
    validates :longitude, presence: { message: "Longitude must be present" }
    # TOOD: Haurem de controlar que university_id estigui a nil si no es un faculty
    
    reverse_geocoded_by :latitude, :longitude, :address => :address
    after_validation :reverse_geocode  # auto-fetch address
end
