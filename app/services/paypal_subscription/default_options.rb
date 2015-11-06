class PaypalSubscription::DefaultOptions
  def self.for(subscriptable, locale)
    {
      period: :monthly,
      outstanding: :no_auto,
      frequency: 1,
      start_at: Time.now,
      trial_length: 0,
      payer_id: subscriptable.paypal_payer_id,
      profile_id: subscriptable.paypal_profile_id,
      reference: subscriptable.id,
      description: subscriptable.plan_paypal_description_I18n(locale),
      amount: subscriptable.plan_price,
      currency: 'USD'
    }
  end
end
