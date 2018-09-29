class Api::V1::CustomersController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_customer, only: %i[show]

  def index
    @customers = Customer.all
  end

  def show
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
