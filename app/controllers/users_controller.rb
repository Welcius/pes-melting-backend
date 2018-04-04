module UsersHelper
    require 'rubygems'
    require 'email_address'
    
    MIN_USER_LENGTH = 6
    MAX_USER_LENGTH = 32
    
    MIN_PASSWORD_LENGTH = 8
    MAX_PASSWORD_LENGTH = 32
    
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
                    render json: { message: "User has been created correctly: please confirm your email." }, :status => :created
                else
                    render json: { message: "The user could not be created.", errors: newuser.errors }, :status => :conflict
                end
            else
                render json: { message: "The fields don't meet the appropiate requirements." }, :status => :bad_request
            end
        else
            render json: { message: "There are missing fields." }, :status => :bad_request
        end
    end
end
