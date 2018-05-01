class LocationSerializer < ActiveModel::Serializer
  attributes :location_id, :name, :address, :latitude, :longitude
  
  def location_id
      object.id
  end
  
end
