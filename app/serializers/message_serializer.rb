class MessageSerializer < ActiveModel::Serializer
  attributes :body, :user_id, :utc_timestamp
end
