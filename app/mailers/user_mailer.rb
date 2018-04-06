class UserMailer < ApplicationMailer
    default from: MELTING_APP_EMAIL_ADDRESS
    
    def activation_email(target_mail, username, activation_code)
        @username = username
        @activation_code = activation_code
        mail(to: target_mail, subject: 'Please, activate your account')
    end
end
