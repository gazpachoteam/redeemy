class Api::V1::TokensController < ApplicationController
  include HandlesAuthentication

  def request_token
    set_authentication_params
    find_user_by_login_handler

    if @error
      throw_500(@message) and return
    end

    if @user
      @user.create_token(@login_handler, @sent_by)
      render json: {
        message: "Token Sent",
        sent_to: @login_handler,
        new_user: false,
        user_type: @user.type
      }, status: 200
    elsif @user.blank?
      @user = User.create_from_email(@login_handler) if @sent_by == "email"
      @user = User.create_from_phone(@login_handler) if @sent_by == "phone"
      @user.create_token(@login_handler, @sent_by)
      render json: {
        message: "Token Sent",
        sent_to: @login_handler,
        new_user: true,
        user_type: @user.type
      }, status: 200
    end
  end

  def authenticate_token
    set_authentication_params
    find_user_by_login_handler or return
    if @user and @user.valid_code? @code
      render json: {
        message: 'User Signed In',
        authentication_token: @user.authentication_token,
        user_id: @user.id,
        user_type: @user.type
        }, status: 200
    elsif @error
      throw_500(@message ? @message : "Something went wrong.")
    else
      render json: {
        message: 'Log In Failed',
      }, status: 401
    end
  end

  def destroy
    @user = User.find_by_authentication_token(params[:auth_token])
    @user.reset_authentication_token!
    @user.save
    render :status=>200, :json=>{}
  end

end
