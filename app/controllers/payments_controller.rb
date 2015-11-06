class PaymentsController < ApplicationController

  before_action :set_payment, only: [:show]
  before_action :check_plan, only: [:new, :create]
  before_action :set_new_payment, only: [:create]

  before_action :authenticate_user!
  load_and_authorize_resource

  # respond_to :html

  def index
    @payments = current_user.payments.order("transaction_status asc")
  end

  def show
  end

  def new
    @payment = current_user.payments.new
  end

  def create
    if @payment.save
      if url = @payment.make_paypal_payment(approve_confirmed_payments_url, approve_denied_payments_url)
        redirect_to url
      else
        render :new
      end
    else
      render :new
    end
  end

  # Response
  # http://<return_url>?paymentId=()&token=()&PayerID=()
  def confirmation_status
    # ID of the payment. This ID is provided when creating payment.
    payment_id = params["paymentId"]
    token = params["token"]
    payer_id = params["PayerID"]

    @paypal_payment = PayPal::SDK::REST::Payment.find(payment_id)
    @payment = Payment.find_by(transaction_id: payment_id)

    # PayerID is required to approve the payment.
    if @paypal_payment.execute(:payer_id => payer_id)
      @payment.update_attribute :transaction_status, :approved
      redirect_to @payment
    else
      @payment.update_attribute :transaction_status, :denied
      redirect_to @payment, notice: @paypal_payment.error.message
    end
  end

  private

  def set_new_payment
    @payment = current_user.payments.new(payment_params)
  end

  def check_plan
    if current_user.valid_program?
      redirect_to payments_path, notice: t('titles.active_plan')
      return
    end
  end

  def set_payment
    @payment = current_user.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:plan_id)
  end

end
