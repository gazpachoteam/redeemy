class ProviderAdmin::DashboardController < ProviderAdminController
  before_action :set_provider

  def index
    @utterances = [
      "Consulta y haz seguimiento a tus ordenes",
      "Actualiza tu catálogo",
      "Genera reportes"
    ]

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@provider.name}-reporte-#{Time.now.to_datetime}",
               layout: 'application',
               disposition: 'attachment'
      end
    end
  end

  private

  def set_provider
    @provider = Provider.find(params[:provider_id])
  end
end
