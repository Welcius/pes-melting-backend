class ApplicationController < ActionController::API
    include Knock::Authenticable
    protect_from_forgery with: :exception
end
