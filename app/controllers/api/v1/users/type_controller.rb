class Api::V1::Users::TypeController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_user

  def index
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
