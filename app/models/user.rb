class User < ApplicationRecord
    has_secure_password
    has_many :events
    has_many :comments
    has_many :votes
    validates_presence_of :code, :username, :email
    
    validates :username, uniqueness: {message: "That username has already been taken" }
    validates :email, uniqueness: {message: "That email has already been taken" }
    
    def to_token_payload
        {sub: id, role: role}
    end
    def self.from_token_request request
        email = request.params["email"]
        if not email.nil?
            user = User.find_by_email(email)
            if not user.nil? and user.activated then return user end
        end
        return nil
    end
end
