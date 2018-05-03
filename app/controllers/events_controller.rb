class EventsController < ApplicationController    
 #   before_action :find_event, only: [:show, :edit, :update, :destroy]       
    before_action :authenticate_user 
    before_action :event_auth, only: [:edit, :update, :destroy]    
    include UtilsModule
    
        def index    
            events = Event.all.order(created_at: :desc)    
            render json: events
        end    

        def new    
            event = current_user.events.build    
        end    

        def create    
            location = Location.create(location_params)
            location.save
            event = current_user.events.create(event_params)
            event.location_id = location.id
            if event.save    
                render json: event, status: :created    
            else    
                sendStatus("Error creating event", :conflict, @event.errors)  
            end 
        end    

        def show   
            event = Event.find_by_id(params[:event_id])
            if event.nil?
                sendStatus("Event does not exist", :not_found)
            else
                render json: { event: event, location: Location.find_by_id(event.location_id)}, status: :ok
            end
        end
            
            
        def edit    
        end    

        def update    
            event = Event.find_by_id(params[:event_id])
            if event.nil?
                sendStatus("Event does not exist", :not_found)
            else
               if event.update(event_params) and event.location.update(location_params)
                    render json: { event: event, location: Location.find_by_id(event.location_id)}, status: :ok
                else
                    sendStatus("Error modifying event", :conflict, event.errors) 
                end
            end
        end
                

        def destroy    
            event = Event.find_by_id(params[:event_id])
            event.destroy    
            render json: @event, status: :destroy      
        end    

        private    

        def event_params    
            params.permit(:title, :description, :user_id, :date)   
        end   
        
        def location_params    
            params.permit(:latitude, :longitude,:address, :name)   
        end

        def find_event   
            event = Event.find(params[:id])    
        end   

        def event_auth    
            if current_user != event.user    
               redirect_to(root_path)    
            end    
        end    
    