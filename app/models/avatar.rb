require "shrine"
# Sense la línia d'abans donarà el següent error: 
# NameError (uninitialized constant Avatar::ImageUploader)

class Avatar < ApplicationRecord
  include ImageUploader[:image]
  
  belongs_to :profile
end
