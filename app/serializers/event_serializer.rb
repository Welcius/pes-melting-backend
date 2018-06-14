class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :latitude, :longitude, :address, :name, :date, :user_id, :num_attendees
  
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
  
  def num_attendees
      Profile.joins(:user => :votes).where('NOT users.account_deleted AND votes.event_id = ?', object.id).count
  end
end
