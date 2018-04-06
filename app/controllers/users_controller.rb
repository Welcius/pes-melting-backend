module UsersHelper
    require 'rubygems'
    require 'email_address'
    
    MIN_USER_LENGTH = 3
    MAX_USER_LENGTH = 20
    
    MIN_PASSWORD_LENGTH = 8
    MAX_PASSWORD_LENGTH = 64
    
    def checkRegisterFields?(email, username, password)
        if not email.nil? and not username.nil? and not password.nil?
            if not EmailAddress.valid?(email) then return false end
            if username.length < MIN_USER_LENGTH or username.length > MAX_USER_LENGTH then return false end
            if password.length < MIN_PASSWORD_LENGTH or password.length > MAX_PASSWORD_LENGTH then return false end
            if not username.match?(/\A[a-z0-9_]*\z/) then return false end
            return true
        end
        return false
    end
    
    def sendStatus(message, status, errors=nil)
        if errors.nil?
            render json: { :message => message }, :status => status
        else
            render json: { :message => message, :errors => errors }, :status => status
        end
    end
end

class UsersController < ApplicationController
    include UsersHelper
    require 'securerandom'
    require 'bcrypt'
    
    def register
        if params.has_key?(:email) and params.has_key?(:username) and params.has_key?(:password)
            if checkRegisterFields?(params[:email], params[:username], params[:password])
                encrypted_pwd = BCrypt::Password.create(params[:password])
                code = SecureRandom.hex[0..7]
                newuser = User.new(:email => params[:email].downcase, :username => params[:username], :password => encrypted_pwd, :code => code)
                if newuser.save
                    UserMailer.activation_email(params[:email], params[:username], code).deliver_now
                    sendStatus("User has been created correctly: please confirm your email", :created)
                else
                    sendStatus("User could not be created", :conflict, newuser.errors)
                end
            else
                sendStatus("Fields don't meet the appropiate requirements", :bad_request)
            end
        else
            sendStatus("Missing fields", :bad_request)
        end
    end
    
    def activate
        if params.has_key?(:email) and params.has_key?(:code)
            user = User.find_by_email(params[:email].downcase)
            if not user.nil?
                if user.code == params[:code]
                    if user.activated
                        sendStatus("User is already activated", :conflict)
                    else
                        user.activated = true
                        if user.save
                            sendStatus("User has been activated", :ok)
                        else
                            sendStatus("User could not be activated", :internal_server_error)
                        end
                    end
                else
                    sendStatus("Mail and/or the code are not correct", :unauthorized)
                end
            else
                sendStatus("Mail and/or the code are not correct", :unauthorized)
            end
        else
            sendStatus("Missing fields", :bad_request)
        end
    end
end
