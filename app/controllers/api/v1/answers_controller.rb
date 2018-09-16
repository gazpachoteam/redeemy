class Api::V1::AnswersController < ApplicationController
  before_action :set_customer

  def get
=begin
    lex_client = Aws::Lex::Client.new(
                    region: ENV["LEX_FAQ_AWS_REGION"],
                    access_key_id: ENV["LEX_FAQ_AWS_ACCESS_ID"],
                    secret_access_key: ENV["LEX_FAQ_AWS_SECRET_ACCESS_KEY"])

    resp = lex_client.post_text({
      bot_name: Lex::Bot::NAME,
      bot_alias: Lex::Bot::VERSION,
      user_id: params[:user_id],
      session_attributes: {},
      input_text: params[:text]
    })
=end
    sleep(3);

    render json: {
      answer: "#{@customer.name}, respuesta + #{params[:text]}",
      dialog_action_type: "Close",
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

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
