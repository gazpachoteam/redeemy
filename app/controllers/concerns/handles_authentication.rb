module HandlesAuthentication
  extend ActiveSupport::Concern

  def find_user_by_login_handler
    @error = false
    if handler_is_an_email?
      @user = User.find_by(email: @login_handler)
      @sent_by = "email"
    elsif handler_is_a_phone?
      @login_handler = clean_phone_number(@login_handler)
      @user = User.find_by_phone_sloppy(@login_handler)
      @sent_by = "phone"
    else
      @error = true
      @message = "Check login handler. US numbers or email only, phone numbers must have area code"
    end
  end

  def handler_is_an_email?
    @login_handler =~ User::VALID_EMAIL_REGEX
  end

  def handler_is_a_phone?
    @login_handler =~ User::VALID_PHONE_NUMBER_REGEX
  end

  def set_authentication_params
    @user_type = params[:type]
    @login_handler = params[:login_handler]
    @login_handler = params[:phone] if params[:phone]
    @code = params[:code]
  end

  def clean_phone_number(phone)
    number = phone
    clean_number = number.delete("^0-9")
    if clean_number.length > 10 and clean_number.first == '1'
      clean_number = clean_number.last(10)
    end
    number = clean_number
  end
end
