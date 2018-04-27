class ProfileSerializer < ActiveModel::Serializer
  attributes :user_id, :full_name, :biography, :karma, :country_code, :university, :university_id, :faculty, :faculty_id, :avatarURL

  def university
    object.faculty.university.name
  end
  
  def university_id
    object.faculty.university.id
  end
  
  def faculty
    object.faculty.name
  end
  
  def faculty_id
    object.faculty.id
  end
  
  def avatarURL
    object.avatar.nil? ? nil : object.avatar.image[:thumb].url
  end
  
end
