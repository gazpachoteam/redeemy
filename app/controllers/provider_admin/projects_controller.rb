class ProviderAdmin::ProjectsController < ProviderAdminController
  before_action :set_provider

  def index
    @projects = @provider.projects
  end

  private

  def set_provider
    @provider = Provider.find(params[:provider_id])
  end
end
