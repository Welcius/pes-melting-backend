class ProfilesController < ApplicationController
    include UtilsModule
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
    
    def create
        user = User.find_by_id(profile_params[:user_id])
        if user.nil?
            sendStatus("User does not exist", :not_found)
        else
            if current_user.id != profile_params[:user_id].to_i
                sendStatus("You don't have permission to create that user profile", :unauthorized);
            else
               if user.profile.nil?
                   p = Profile.create(profile_params)
                   if p.save
                       sendStatus("Profile created", :ok)
                   else
                       sendStatus("Error creating profile", :conflict, p.errors)
                   end
               else
                   sendStatus("Profile already exists", :conflict)
               end
            end
        end
    end
    
    def update
        user = User.find_by_id(profile_params[:user_id])
        if user.nil?
            sendStatus("User does not exist", :not_found)
        else
            if current_user.id != profile_params[:user_id].to_i
                sendStatus("You don't have permission to modify that user profile", :unauthorized);
            else
               if user.profile.nil?
                   sendStatus("Profile does not exist", :not_found)
               else
                   p = user.profile
                   p.update(profile_params)
                   if p.save
                       sendStatus("Profile modified", :ok)
                   else
                       sendStatus("Error modifying profile", :conflict, p.errors)
                   end
               end
            end
        end
    end
    
    def set_avatar
        if current_user.id != params[:user_id].to_i
            sendStatus("You don't have permission to modify that user profile", :unauthorized);
        else
            img = params[:profile][:avatar]
            f = File.open(img.path())
            uploader = ImageUploader.new(:store)
            shrine_file = uploader.upload(f)
            profile = User.find_by_id(current_user.id).profile
            if profile.avatar.nil?
                profile.avatar = Avatar.create()
            end
            profile.avatar.update(:image => shrine_file)
            profile.save
        end
    end
    
    private

    def profile_params
        params.require(:profile).permit(:user_id, :faculty_id, :full_name, :country_code, :biography, :avatar)
    end
end
