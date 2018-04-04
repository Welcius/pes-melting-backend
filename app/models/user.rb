class User < ApplicationRecord
    
    
    validates_presence_of :code, :username, :email
    
    validates :username, uniqueness: {message: "That username has already been taken" }
    validates :email, uniqueness: {message: "That email has already been taken" }
end
