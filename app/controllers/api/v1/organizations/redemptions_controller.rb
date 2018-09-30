class Api::V1::Organizations::RedemptionsController < ApplicationController
  before_action :set_organization

  def index
    @redemptions = @organization.redemptions
  end

  def show
    @redemption = Redemption.find(params[:id])
    render json: @redemption
  end

  def create
    @redemption = Redemption.new(redemption_params)
      if @redemption.save
        render json: {message: 'Redemption Saved'}, status: 200
      else
        render json: {errors: @redemption.errors.full_messages}, status: 400
      end
  end

  def update
    @redemption = Redemption.find(params[:id])
    if @redemption.update(redemption_params)
      render json: @redemption, status: 200
    else
      render json: { errors: @redemption.errors.full_messages}, status: 400
    end
  end

  def destroy
    @redemption = Redemption.find(params[:id])
    if @redemption.destroy
      render json: {message: 'Redemption Deleted'}, status: 200
    else
      render json: { errors: @redemption.errors.full_messages}, status: 400
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def redemption_params
    params.permit(:customer_id, :project_id, :points)
  end
end
