module UtilsModule
    def sendStatus(message, status, errors=nil)
        if errors.nil?
            render json: { :message => message }, :status => status
        else
            render json: { :message => message, :errors => errors }, :status => status
        end
    end
    
    def same_user_as_current(user_id)
      return user_id == current_user.id 
    end
end