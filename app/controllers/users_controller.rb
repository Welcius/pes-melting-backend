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
end

class UsersController < ApplicationController
    before_action :authenticate_user, :except => [:register, :activate]
    include UsersHelper
    include UtilsModule
    require 'securerandom'
    require 'bcrypt'
    
    def register
        if params.has_key?(:email) and params.has_key?(:username) and params.has_key?(:password)
            if checkRegisterFields?(params[:email], params[:username], params[:password])
                encrypted_pwd = BCrypt::Password.create(params[:password])
                code = SecureRandom.hex[0..7]
                newuser = User.new(:email => params[:email].downcase, :username => params[:username], :password_digest => encrypted_pwd, :code => code, :last_status => Time.now.to_i)
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
    
    def delete
        user = User.find_by_id(params[:user_id])
        if user.nil?
            sendStatus("User does not exist", :not_found)
        else
            if not same_user_as_current(params[:user_id].to_i)
                sendStatus("You don't have permission to delete that user", :unauthorized)
            else
                if user.account_deleted
                    sendStatus("The user is already deleted", :conflict)
                else
                    if user.update(:account_deleted => true)
                        sendStatus("The user was deleted", :ok)
                        if not user.profile.nil?
                            user.profile.update(:full_name => 'Deleted')
                        end
                    else
                        sendStatus("Error deleting user", :conflict)
                    end
                end
            end
        end
    end
end