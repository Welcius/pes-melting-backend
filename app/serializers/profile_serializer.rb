class ProfileSerializer < ActiveModel::Serializer
  attributes :user_id, :full_name, :biography, :karma, :country_code, :university, :faculty, :avatarURL

  def university
      object.faculty.university.name
  end
  
  def faculty
      object.faculty.name
  end
  
  def avatarURL
      object.avatar.nil? ? nil : object.avatar.image[:thumb].url
  end
  
end
