class ProviderAdmin::RedeemablesController < ProviderAdminController
  before_action :set_provider

  def index
    @redeemables = @provider.redeemables
  end

  private

  def set_provider
    @provider = Provider.find(params[:provider_id])
  end
end
