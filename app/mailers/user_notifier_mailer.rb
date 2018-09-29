class UserNotifierMailer < ApplicationMailer
  default :from => 'info@redeemy.com'

  def send_code(user, code)
    @user = user
    @code = code
    mail( :to => @user.email,
    :subject => "Redeemy Token Code (#{@code})" )
  end

end
