class UserTokenController < Knock::AuthTokenController
    private
    
    def auth_params
      params.permit :email, :password
    end
end
