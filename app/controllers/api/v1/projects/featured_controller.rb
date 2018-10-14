class Api::V1::Projects::FeaturedController < ApplicationController

  def index
    @featured_projects = Project.featured
    render json: @featured_projects
  end
end
