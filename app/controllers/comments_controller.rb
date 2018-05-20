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
          event = Comment.find(params[:user_id])
          comments = event.comments
          render json: comments
        end
        
        def create
          event = Event.find(params[:event_id])
          comment = event.comments.create(params[:comment].permit(:content))
          comment.user_id=current_user.id if current_user
          comment.save
        
          if comment.save
            render json: comment, status: :created  
          else
            sendStatus("Error creating comment", :conflict, comment.errors)  
          end
        end   
        
        def update    
            #event = Event.find_by_id(params[:event_id])
            comment = Comment.find_by_id((params[:comment_id]))
            if same_user_as_current(comment.user_id)
                if comment.nil?
                    sendStatus("Comment does not exist", :not_found)
                else
                    c = comment.update(comment_params)
                  #  if e.update(event_params) and l.update(location_params)
                        render json: { comment:comment}, status: :ok
                #   else
                #       sendStatus("Error modifying event", :conflict, e.errors) 
                  # end
                end
            else
                sendStatus("Current user != creator of the event", :conflict, event.errors) 
            end
            
        end

        def destroy    
            comment = Comment.find_by_id(params[:comment_id])
            event = Event.find_by_id(params[:event_id])
            if((comment.event_id == event.id) || same_user_as_current(comment.user_id))
              comment.destroy
              render json: comment, status: :destroy   
            else
              sendStatus("Current user != creator of the event", :conflict, comment.errors) 
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