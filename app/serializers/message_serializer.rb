class MessageSerializer < ActiveModel::Serializer
  attributes :body, :user_id, :username, :utc_timestamp
  
  def username
      object.user.username
  end
  
end
