class Api::V1::Providers::ProjectsController < ApplicationController
  before_action :set_provider
  def index
    @projects = @provider.projects
    render json: @projects
  end

  private

  def set_provider
    @provider = Provider.find(params[:provider_id])
  end
end
