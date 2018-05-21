class ChatroomsController < ApplicationController
    include UtilsModule
    
    before_action :authenticate_user
    
    def connected_users_profiles
        # Els usuaris connectats són aquells que han llegit algun missatge de
        # la sala de qualsevol chat en els últims 40 segons
        render json: Profile.joins(:user).where('? - users.last_chat_heartbeat <= 40', Time.now.utc.to_i)
    end
    
    def get_messages
        if params.has_key?(:since) and params.has_key?(:id)
            chatroom = Chatrom.find_by_id(params[:id])
            if not chatroom.nil?
                since = params[:since].to_i
                current_user.last_chat_heartbeat = Time.now.utc.to_i
                render json: chatroom.messages.where('utc_timestamp > ?', since)
            else
                sendStatus("Chatroom does not exist", :not_found)
            end
        else
            sendStatus("Missing fields", :bad_request)
        end
    end
    
    def send_message
        
    end
end
