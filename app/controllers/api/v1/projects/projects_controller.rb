class Api::V1::Projects::ProjectsController < ApplicationController
  def index
    if params[:category_id].present?
      @projects = Project.by_category(params[:category_id])
    else
      @projects = Project.all
    end
    render json: @projects
  end

  def show
    @project = Project.find(params[:id])
    render json: @project
  end
  def create
    @organization = Organization.find_by_id(params[:organization_id])
    unless @organization
      @organization = Organization.create(id: params[:organization_id], name: params[:organization_name])
    end

    @project = @organization.projects.build(project_params)
      if @project.save
        render json: {message: 'Project Saved'}, status: 200
      else
        render json: {errors: @project.errors.full_messages}, status: 400
      end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: @project, status: 200
    else
      render json: { errors: @project.errors.full_messages}, status: 400
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      render json: {message: 'Project Deleted'}, status: 200
    else
      render json: { errors: @project.errors.full_messages}, status: 400
    end
  end

  private

  def project_params
    params.permit(:name, :description, :category, :expiration)
  end
end
