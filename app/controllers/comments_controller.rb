module CommentsHelper
   def same_user_as_current(user_id)
      return user_id == current_user.id 
   end
end

class CommentsController < ApplicationController
      # before_action :find_comment, only: [:create, :destroy]    
      # before_action :comment_auth, only: [:destroy]    
        before_action :authenticate_user
        include UtilsModule
        include CommentsHelper
        
        def index
          event = Event.find_by_id(params[:event_id].to_i)
          if not event.nil?
            comments = event.comments
            render json: comments
          else
            sendStatus("Event not found", :not_found)
          end
        end
        
        def create
          event = Event.find_by_id(params[:event_id].to_i)
          if not event.nil?
              comment = event.comments.create(params[:comment].permit(:content))
              comment.user_id=current_user.id if current_user
              comment.save
              if comment.save
                  if not current_user.profile.nil? 
                    current_user.profile.add_karma(3)  
                  end
                render json: comment, status: :created  
              else
                sendStatus("Error creating comment", :conflict, comment.errors)  
              end
          else
              sendStatus("Event not found")
          end
        end   
        
        def update    
            #event = Event.find_by_id(params[:event_id])
            comment = Comment.find_by_id((params[:comment_id]))
            if not comment.nil?
                if same_user_as_current(comment.user_id)
                    comment.update(comment_params)
                  #  if e.update(event_params) and l.update(location_params)
                    render json: comment, status: :ok
                #   else
                #       sendStatus("Error modifying event", :conflict, e.errors) 
                  # end
                else
                    sendStatus("Current user != creator of the event", :conflict, event.errors) 
                end
            else
                sendStatus("Comment does not exist", :not_found)
            end
        end

        def destroy    
            comment = Comment.find_by_id(params[:comment_id])
            if comment.nil?
              sendStatus("Comment not found", :not_found)
            else
                if same_user_as_current(comment.user_id)
                    comment.destroy
                    if not current_user.profile.nil? 
                        current_user.profile.add_karma(-3)
                    end
                    sendStatus("Comment erased", :ok)
                else
                    sendStatus("Current user != creator of the event", :conflict, comment.errors) 
                end
            end    
        end
    
        private    

        def comment_params    
            params.require(:comment).permit(:content, :user_id, :event_id)    
        end   

        def find_comment    
            event = Event.find(params[:event_id])    
        end   

        def comment_auth    
            if current_user != event.user    
            redirect_to(root_path)   
            end    
        end     

end