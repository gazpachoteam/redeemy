class ApplicationController < ActionController::Base
  include Response
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { message: 'Not Found' }, status: 404
  end

  def throw_500(message)
    render json: {
      message: message,
    }, status: 500
  end

  def api_return(message, status)
    render json: {
      message: message,
    }, status: status
  end

  def authenticate_user_from_token!
    @auth_token = request.headers['AUTH_TOKEN'] || request.headers['HTTP_AUTH_TOKEN'] || params[:auth_token]
    if @auth_token
      @user = User.find_by_authentication_token(@auth_token)
      if @user
        sign_in @user, store: false
      end
    end
    authenticate_user!
  end
end
