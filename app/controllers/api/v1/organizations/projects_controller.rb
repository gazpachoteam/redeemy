class Api::V1::Organizations::ProjectsController < ApplicationController
  before_action :set_organization
  def index
    @projects = @organization.projects
    render json: @projects
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end
