module EventsHelper
   def same_user_as_current(user_id)
      return user_id == current_user.id 
   end
end

class EventsController < ApplicationController    
 #   before_action :find_event, only: [:show, :edit, :update, :destroy]       
    before_action :authenticate_user 
  #  before_action :event_auth, only: [:edit, :update, :destroy]    
    include UtilsModule
    include EventsHelper
    
    
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
                render json: event
            end
        end
            
            
        def edit    
        end    

        def update    
            event = Event.find_by_id(params[:event_id])
            if same_user_as_current(event.user_id)
                if event.nil?
                    sendStatus("Event does not exist", :not_found)
                else
                    l = Location.find_by_id(event.location_id).update(location_params)
                    e = event.update(event_params) 
                  #  if e.update(event_params) and l.update(location_params)
                        render json: { event: event, location: Location.find_by_id(event.location_id)}, status: :ok
                 #   else
                #       sendStatus("Error modifying event", :conflict, e.errors) 
                   # end
                end
            else
                sendStatus("Current user != creator of the event", :conflict, event.errors) 
            end
            
        end
                

        def destroy    
            event = Event.find_by_id(params[:event_id])
            if same_user_as_current(event.user_id)
                event.destroy    
                render json: event, status: :destroy 
            else
                sendStatus("Current user != creator of the event", :conflict, event.errors) 
            end
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
            if current_user.id != event.user_id    
               sendStatus("The user is not the creator of the event", :conflict)  
            end    
        end    
end