class LocationSerializer < ActiveModel::Serializer
  attributes :location_id, :name, :alias, :address, :telephone, :url, :latitude, :longitude
  
  def location_id
      object.id
  end
  
end
