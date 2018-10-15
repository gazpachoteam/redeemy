class Api::V1::OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def create
    @organization = Organization.new(organization_params)
      if @organization.save
        render json: {message: 'Organization Saved'}, status: 200
      else
        render json: {errors: @organization.errors.full_messages}, status: 400
      end
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update(provider_params)
      render json: @organization, status: 200
    else
      render json: { errors: @organization.errors.full_messages}, status: 400
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    if @organization.destroy
      render json: {message: 'Organization Deleted'}, status: 200
    else
      render json: { errors: @organization.errors.full_messages}, status: 400
    end
  end

  private

  def organization_params
    params.permit(:name)
  end
end
