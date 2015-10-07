class AdminMailer < ApplicationMailer

  def new_user(user)
    @user = user
    mail(to: 'admin@email.com', subject: 'New user added')
  end
end
