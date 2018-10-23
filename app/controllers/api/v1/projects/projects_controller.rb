class Api::V1::Projects::ProjectsController < ApplicationController
  def index
    if params[:category_id].present?
      @projects = Project.by_category(params[:category_id])
    else
      @projects = Project.all
    end
  end

  def show
    @project = Project.find(params[:id])
    
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @project = Project.new(project_create_params)
      if @project.save
        render json: @project, status: 201
      else
        render json: {errors: @project.errors.full_messages}, status: 400
      end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_update_params)
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

  def project_update_params
    params.require(:project).permit(:name, :description)
  end

  def project_create_params
    params.require(:project).permit(:name, :description, :organization_id)
  end
end
