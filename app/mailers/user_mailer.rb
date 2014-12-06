class UserMailer < ActionMailer::Base
  default from: "octave@gocardless.com"

  def welcome_email(user)
  	@user = user
  	mail(to: @user.email, subject: 'Welcome to Unicorn')
  end
end
