    def sendStatus(message, status, errors=nil)
        if errors.nil?
            render json: { :message => message }, :status => status
        else
            render json: { :message => message, :errors => errors }, :status => status
        end
    end
class ProfilesController < ApplicationController
    before_action :authenticate_user
    def show
        if params[:user_id].nil? or params[:user_id].to_i <= 0
            sendStatus("Invalid user id", :bad_request)
        else
            user = User.find_by_id(params[:user_id])
            if user.nil?
                sendStatus("User does not exist", :not_found)
            else
                if user.profile.nil?
                    sendStatus("Profile not created yet", :not_found)
                else
                    # TODO: manera cutre per a provar
                    render json: { profile: user.profile.as_json(:except => [:id, :created_at, :updated_at]) }
                end
            end
        end
    end
    
    def update
        if profile_params
            user = User.find_by_id(profile_params[:user_id])
            if user.nil?
                sendStatus("User does not exist", :not_found)
            else
                if current_user.id != profile_params[:user_id].to_i
                    sendStatus("You don't have permission to modify that user profile", :unauthorized);
                else
                   p = nil
                   if user.profile.nil?
                       p = Profile.create(profile_params)
                   else
                       p = user.profile
                       p.update(profile_params)
                   end
                   
                   if p.save
                       sendStatus("Profile modified", :ok)
                   else
                       sendStatus("Error saving profile", :conflict, p.errors)
                   end
                end
            end
        else
            sendStatus("Missing fields", :bad_request);
        end
    end
    
    private
    def profile_params
        params.require(:profile).permit(:user_id, :faculty_id, :full_name, :country_code, :biography)
    end
end
