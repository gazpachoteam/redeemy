class Api::V1::AnswersController < ApplicationController
  before_action :set_user

  def get
    assistant = AssistantV1.new(
      username: ENV["IBM_USERNAME"],
      password: ENV["IBM_PASSWORD"],
      version: "2017-04-21"
    )

    context = params[:context] == "" ? {} : JSON.parse(params[:context])

    response = assistant.message(
      workspace_id: ENV["IBM_WORKSPACE_ID"],
      input: {
        "text" => params[:text]
      },
      context: context
    ).result

    answer = response["output"]["text"][0]

    if response["intents"].map {|i| i["intent"]}.include? "ventas_puntos"
      provider_points = @user.redemptions.map(&:points).inject(:+)
      answer = "Usted a acumulado #{provider_points} puntos en ventas"
      context = {}
    end

    if response["intents"].map {|i| i["intent"]}.include? "ventas_producto"
      provider_sells = @user.redemptions.count
      answer = "Usted a ha vendido #{provider_sells} productos"
      context = {}
    end

    if context.key? "Cliente"
      provider_projects_ids = @user.projects.map(&:id)

      client_detail = CustomerDetail.where(name: params[:text]).first
      customer = client_detail.customer
      orders = Redemption.where(project_id: provider_projects_ids, customer_id: customer.id)

      orders_text = orders.map {|o| "id:#{o.id}: #{o.points} puntos redimidos por #{o.project.name}"}.join("<br>")

      answer = "Los últimos pedidos de #{customer.name} son:<br> #{orders_text}"

      context = {}
    end

    render json: {
      answer: "#{@user.name}, #{answer}",
      dialog_action_type: "Close",
      context: response["context"],
      fulfillment_state: "Fulfilled",
      status: 200
      } and return

  rescue => e
    status = @answer.present? ? 500 : 404
    render json: {
      answer: "OH NO! Something went wrong: #{e.inspect}",
      fulfillment_state: 'Fulfilled',
      dialog_action_type: "Close",
      status: status
    } and return
  end

  private

  def set_user
    if params[:user_type] == "Provider"
      @user = Provider.find(params[:user_id])
    end
  end
end
