class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :latitude, :longitude, :address, :name, :date, :user_id
  
  def latitude
      object.location.latitude
  end
  
  def longitude
      object.location.longitude
  end
  
  def address
      object.location.address
  end
  
  def name
      object.location.name
  end
end
