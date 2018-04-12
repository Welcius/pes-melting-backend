class User < ApplicationRecord
    has_secure_password
    
    validates_presence_of :code, :username, :email
    
    validates :username, uniqueness: {message: "That username has already been taken" }
    validates :email, uniqueness: {message: "That email has already been taken" }
    
    def self.to_token_payload
        {sub: id, role: role}
    end
    def self.from_token_request request
        email = request.params["auth"] && request.params["auth"]["email"]
        user = User.find_by_email(email)
        if not user.nil? and user.activated then return user end
        return nil
    end
end
