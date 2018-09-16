class Dashboard::DashboardController < DashboardController
  def index
    @user = Provider.new
  end
end
