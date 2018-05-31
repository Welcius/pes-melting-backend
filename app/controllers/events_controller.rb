module EventsHelper
   def same_user_as_current(user_id)
      return user_id == current_user.id 
   end
end

class EventsController < ApplicationController    
    before_action :authenticate_user 
    
    include UtilsModule
    include EventsHelper
    
        def index    
            events = Event.all.order(created_at: :desc)
            if not params[:user_id].nil?
                events = events.where(:user_id => params[:user_id].to_i)
            end
            render json: events
        end    

        def create    
            location = Location.create(location_params)
            if location.save?
                event = current_user.events.create(event_params)
                event.location = location
                if event.save    
                    render json: event, status: :created    
                else    
                    sendStatus("Error creating event", :bad_request, event.errors)  
                end 
            else
                sendStatus("Error creating location", :bad_request, location.errors)  
            end
        end    

        def show   
            event = Event.find_by_id(params[:event_id].to_i)
            if event.nil?
                sendStatus("Event doesn't exist", :not_found)
            else
                render json: event
            end
        end

        def update    
            event = Event.find_by_id(params[:event_id])
            if not event.nil?
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
            else
                sendStatus("Event doesn't exist", :not_found)
            end
            
        end
                
        def destroy    
            event = Event.find_by_id(params[:event_id].to_i)
            if not event.nil?
                if same_user_as_current(event.user_id)
                    event.destroy    
                    sendStatus("Event erased", :ok) 
                else
                    sendStatus("Current user != creator of the event", :conflict, event.errors) 
                end
            else
                sendStatus("Event doesn't exist", :not_found)
            end
        end
        
        def attendees
            event = Event.find_by_id(params[:event_id].to_i)
            if not event.nil?
                if event.votes.count == 0
                    render :json => []
                else
                    render json: Profile.joins(:user => :votes).where('votes.event_id = ?', event.id)
                end
            else
                sendStatus("Event doesn't exist", :not_found)
            end
        end

        private    

        def event_params    
            params.permit(:title, :description, :date)   
        end   
        
        def location_params    
            params.permit(:latitude, :longitude,:address, :name)   
        end
end