class ApplicationController < ActionController::API
    include Knock::Authenticable
    include ActionController::RequestForgeryProtection
  
end
