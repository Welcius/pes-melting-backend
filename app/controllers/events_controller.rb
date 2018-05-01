class EventsController < ApplicationController    
    before_action :find_event, only: [:show, :edit, :update, :destroy]       
    before_action :authenticate_user 
    before_action :event_auth, only: [:edit, :update, :destroy]    

        def index    
            @events = Event.all.order(created_at: :desc)    
        end    

        def new    
            @event = current_user.events.build    
        end    

         def create    
             @event = current_user.events.create(event_params) 
             if @event.save    
                render json: @event, status: :created    
             else    
                sendStatus("Error creating event", :conflict, @event.errors)  
             end    
         end    

        def show   
            
        end    

        def edit    
        end    

        def update    
            if @event.update(params[:post].permit(:title, :description, :user_id, :latitude, :longitude, :address, :name))    
                render json: @event
            else   
                sendStatus("Error modifying event", :conflict, @event.errors)   
            end    
        end    

        def destroy    
            @event.destroy    
            render json: @event, status: :destroy      
        end    

        private    

        def event_params    
            params.permit(:title, :description, :user_id, :latitude, :longitude, :address, :name)   
        end   

        def find_event   
            @event = Event.find(params[:id])    
        end   

        def event_auth    
            if current_user != @event.user    
               redirect_to(root_path)    
            end    
        end    
    end