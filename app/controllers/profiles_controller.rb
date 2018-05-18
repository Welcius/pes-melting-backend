class ProfilesController < ApplicationController
    include UtilsModule
    
    before_action :authenticate_user
    
    def show
        user = User.find_by_id(params[:user_id])
        if user.nil?
            sendStatus("User does not exist", :not_found)
        else
            if user.profile.nil?
                sendStatus("Profile not created yet", :not_found)
            else
                render json: user.profile
            end
        end
    end
    
    def create
        user = User.find_by_id(params[:user_id])
        if user.nil?
            sendStatus("User does not exist", :not_found)
        else
            if not same_user_as_current(params[:user_id].to_i)
                sendStatus("You don't have permission to create that user profile", :unauthorized);
            else
               if user.profile.nil?
                   p = Profile.new(profile_params)
                   if p.save
                       render json: p, status: :created
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
        user = User.find_by_id(params[:user_id])
        if user.nil?
            sendStatus("User does not exist", :not_found)
        else
            if not same_user_as_current(params[:user_id].to_i)
                sendStatus("You don't have permission to modify that user profile", :unauthorized)
            else
               if user.profile.nil?
                   sendStatus("Profile does not exist", :not_found)
               else
                   p = user.profile
                   p.update(profile_params)
                   if p.update(profile_params)
                       render json: p
                   else
                       sendStatus("Error modifying profile", :conflict, p.errors)
                   end
               end
            end
        end
    end
    
    def show_faculty
        user = User.find_by_id(params[:user_id])
        if user.nil?
            sendStatus("User does not exist", :not_found)
        else
           if user.profile.nil?
               sendStatus("Profile does not exist", :not_found)
           else
               render json: user.profile.faculty
           end
        end
    end
    
    def set_avatar
        if not same_user_as_current(params[:user_id].to_i)
            sendStatus("You don't have permission to modify that user profile", :unauthorized);
        else
            img = params[:profile][:avatar]
            f = File.open(img.path())
            uploader = ImageUploader.new(:store)
            shrine_file = uploader.upload(f)
            f.close()
            p = User.find_by_id(current_user.id).profile
            if p.avatar.nil? then p.avatar = Avatar.create() end
            p.avatar.update(:image => shrine_file)
            if p.avatar.valid? 
                sendStatus("Avatar updated successfully", :ok)
            else
                sendStatus("Invalid avatar", :bad_request, p.avatar.errors)
                File.delete(img.path()) if File.exist?(img.path())
                uploader.delete(shrine_file)
            end
        end
    end
    
    private

    def profile_params
        params.permit(:user_id, :faculty_id, :full_name, :country_code, :biography, :avatar)
    end
end
