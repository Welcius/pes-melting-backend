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
            chatroom = Chatroom.find_by_id(params[:id])
            if not chatroom.nil?
                since = params[:since].to_i
                current_user.update(:last_chat_heartbeat => Time.now.utc.to_i)
                render json: chatroom.messages.where('utc_timestamp > ?', since).order(:utc_timestamp)
            else
                sendStatus("Chatroom does not exist", :not_found)
            end
        else
            sendStatus("Missing fields", :bad_request)
        end
    end
    
    def send_message
        if params.has_key?(:body) and params.has_key?(:id)
            chatroom = Chatroom.find_by_id(params[:id])
            if not chatroom.nil?
                if not current_user.profile.nil?
                    if not params[:body].blank?
                        msg = Message.new(:body => params[:body], :user => current_user, :utc_timestamp => Time.now.utc.to_i)
                        chatroom.messages << msg
                        if msg.save and chatroom.save
                            render json: msg, status: 201
                        else
                            sendStatus("There was an error sending the message", 500, msg.errors)
                        end
                    else
                        sendStatus("Message body can't be blank", :bad_request)
                    end
                else
                    sendStatus("User profile not found", :not_found)
                end
            else
                sendStatus("Chatroom does not exist", :not_found)
            end
        else
            sendStatus("Missing fields", :bad_request)
        end
    end
end
