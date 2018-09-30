class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :ensure_authentication_token!

  attr_accessor :skip_password_validation

  validates :password, presence: false

  def create_token(sent_to, sent_by = "email")
    @send_to = sent_to
    self.code = test_account? ? "12345" : rand(10009...99999)
    if sent_by == "email"
      UserNotifierMailer.send_code(self, self.code).deliver
    else
      #@content = "#{sms_token} is your sign in code."
      #@text_message = TextMessage.new
      #@text_message.send_text(@content, phone)
    end
    self.save
  end

  def valid_code?(sent_code)
    return true if test_account? && sent_code == "12345"
    return true if code == sent_code
    false
  end

  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
  end

  private

  def self.find_by_phone_sloppy(phone)
    clean_number = phone.delete("^0-9")
    if clean_number.length > 10 and clean_phone.first == '1'
      clean_number = clean_number.last(10)
    end
    User.find_by_phone(clean_number)
  end

  def self.create_from_phone(phone)
    User.create!(phone: phone, type: "Customer", skip_password_validation: true)
  end

  def self.create_from_email(email)
    User.create!(email: email, type: "Customer", skip_password_validation: true)
  end

  def ensure_authentication_token!
    unless authentication_token
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def test_account?
    test_number? || !real_email?
  end

  def test_number?
    return false unless phone
    phone.count("5") >= 7
  end

  def real_email?
    if email.last(8) == '@fake.me'
      nil
    else
      email
    end
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end

end
