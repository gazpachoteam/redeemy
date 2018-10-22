class Api::V1::Customers::RedemptionsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_customer

  def index
    @redemptions = @customer.redemptions
  end


  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

end
