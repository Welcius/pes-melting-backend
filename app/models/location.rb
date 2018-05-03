class Location < ApplicationRecord
    validates_presence_of :latitude
    validates_presence_of :longitude
    has_many :events
    # TOOD: Haurem de controlar que university_id estigui a nil si no es un faculty
    
    reverse_geocoded_by :latitude, :longitude, :address => :address
    after_validation :reverse_geocode  # auto-fetch address
end
