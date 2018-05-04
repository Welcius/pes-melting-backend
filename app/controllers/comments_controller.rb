class CommentsController < ApplicationController
        before_action :find_comment, only: [:create, :destroy]    
        before_action :comment_auth, only: [:destroy]    
        before_action :authenticate_user
        include UtilsModule
        
        def index
          @event = Event.find(params[:event_id])
          @comments = @event.comments
        end
        
        def create
          @event = Event.find(params[:event_id])
          @comment = @event.comments.create(params[:comment].permit(:content))
          @comment.user_id=current_user.id if current_user
          @comment.save
        
          if @comment.save
            render json: @comment, status: :created  
          else
            sendStatus("Error creating comment", :conflict, @comment.errors)  
          end
        end   

        def destroy    
            @comment = @event.comments.find(params[:id]).destroy    
            render json: @comment, status: :destroy   
        end    

        private    

        def comment_params    
            params.require(:comment).permit(:content)    
        end   

        def find_comment    
            @event = Event.find(params[:post_id])    
        end   

        def comment_auth    
            if current_user != @event.user    
            redirect_to(root_path)   
            end    
        end     

    end