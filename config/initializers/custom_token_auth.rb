Knock::AuthTokenController.class_eval do

  private
    def auth_params
      # instead of params.require(:auth).permit :email, :password
      # you would need to
      params.permit :email, :password
    end
end