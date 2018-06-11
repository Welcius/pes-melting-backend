class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :username, :event_id, :created_at, :updated_at
  
  def username
      object.user.username
  end

end
