class SubscriptionsController < ApplicationController

  before_action :subscription, except: [:index, :create]

  load_and_authorize_resource

  def index
    @subscriptions = current_user.subscriptions.with_deleted.includes(:plan).all.order(canceled: :asc).paginate(page: params[:page], per_page: 10)
    @plans = Plan.all.order(created_at: :asc)
  end

  def show
  end

  def create
    unless current_user.has_a_subscription_payed_active?
      @subscription = current_user.subscriptions.create(subscription_params)
      if @subscription.save
        current_user.cancel_default_subscription
      end
      redirect_to checkout_url
    else
      redirect_to subscriptions_path, notice: I18n.t('controllers.subscriptions.cancel_first')
    end
  end

  def make_recurring
    if PaypalSubscription::RecurrenceCreator.create!(
        subscription: subscription,
        paypal_options: paypal_options.merge({
          payer_id: params[:PayerID],
          token: params[:token]
        })
      )
      redirect_to subscription_path(subscription), notice: I18n.t('controllers.subscriptions.create')
    end
  end

  def destroy
    result = @subscription.update_attributes(deleted_at: Time.now, canceled: true)
    current_user.add_default_subscription if result
    redirect_to subscriptions_url, notice: I18n.t('controllers.subscriptions.destroy')
  end

  private

    def checkout_url
      PaypalSubscription::ResourceFacade.checkout_url(
        paypal_options.merge({
          return_url: make_recurring_subscription_url(subscription),
          cancel_url: subscription_url(subscription, aborting_operation: true)
        })
      )
    end

    def paypal_options
      @paypal_options ||= PaypalSubscription::DefaultOptions.for(subscription, params[:locale])
    end

    def subscription
      @subscription ||= current_user.subscriptions.with_deleted.find(params[:id])
    end

    def subscription_params
      params.permit(:plan_id)
    end

end
