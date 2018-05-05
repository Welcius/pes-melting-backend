class UserTokenController < Knock::AuthTokenController
    private
    
    def auth_params
      params.permit :email, :password
    end
    
    def authenticate
      unless entity.present? && entity.authenticate(auth_params[:password]) && entity.activated? && !entity.account_deleted? then
        raise Knock.not_found_exception_class
      end
    end
end
