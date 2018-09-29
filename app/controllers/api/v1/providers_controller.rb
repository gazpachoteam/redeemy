class Api::V1::ProvidersController < ApplicationController

  def index
    @providers = Provider.all
    render json: @providers
  end

  def show
    @provider = Provider.find(params[:id])
    @provider_projects = @provider.projects.count
    @provider_redemptions = @provider.redemptions.count
  end

  def create
    @provider = Provider.new(provider_params)
      if @provider.save
        render json: {message: 'Provider Saved'}, status: 200
      else
        render json: {errors: @provider.errors.full_messages}, status: 400
      end
  end

  def update
    @provider = Provider.find(params[:id])
    if @provider.update(provider_params)
      render json: @provider, status: 200
    else
      render json: { errors: @provider.errors.full_messages}, status: 400
    end
  end

  def destroy
    @provider = Provider.find(params[:id])
    if @provider.destroy
      render json: {message: 'Provider Deleted'}, status: 200
    else
      render json: { errors: @provider.errors.full_messages}, status: 400
    end
  end

  private

  def provider_params
    params.permit(:name)
  end
end
