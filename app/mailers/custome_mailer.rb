class CustomMailer < Devise::Mailer
    # Use Letter Opener to open emails in the browser instead of sending them
    def self.deliver(*args)
        message = super
        message.deliver!
    end

    # Customize the confirmation_instructions email
    def confirmation_instructions(record, token, opts = {})
        @token = token
        @record = record
        devise_mail(record, :confirmation_instructions, opts)
    end
end
