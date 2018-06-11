class UserMailer < ApplicationMailer
    include URI
    default from: MELTING_APP_EMAIL_ADDRESS
    
    def activation_email(target_mail, username, activation_code)
        @username = username
        @activation_code = activation_code
        mail(to: target_mail, subject: 'Please, activate your account')
    end
    
    def reset_email(target_mail, username, confirm_url)
        @username = username
        @confirm_url = confirm_url
        mail(to: target_mail, subject: 'Confirm your password reset')
    end
    
    def password_email(target_mail, username, new_password)
        @username = username
        @new_password = new_password
        mail(to: target_mail, subject: 'Your new password')
    end
end
