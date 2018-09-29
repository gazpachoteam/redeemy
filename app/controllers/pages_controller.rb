class PagesController < ApplicationController
  def catalog
    @projects = Project.all
  end
end
