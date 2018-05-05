class User < ApplicationRecord
    has_secure_password
    has_one :profile
    
    has_many :events
    has_many :comments
    has_many :votes
    validates_presence_of :username, :email, :code, :last_status
    
    validates :username, uniqueness: {message: "has already been taken" }
    validates :email, uniqueness: {message: "has already been taken" }
    
    def to_token_payload
        {sub: id, role: role, last_status: last_status}
    end
    
    def from_token_request request
        email = request.params["email"]
        if not email.nil?
            user = User.find_by_email(email)
            if not user.nil? and user.activated and not user.account_deleted then return user end
        end
        return nil
    end
    
    def self.from_token_payload payload
        user = User.find(payload["sub"])
        if payload["last_status"] == user.last_status then user else nil end
    end
end
