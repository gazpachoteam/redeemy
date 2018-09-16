class Dashboard::ProvidersController < DashboardController
  def index
    @providers = Provider.all
  end
  def new

  end
end
