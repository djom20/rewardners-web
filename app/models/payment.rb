# == Schema Information
#
# Table name: payments
#
#  id                      :integer          not null, primary key
#  user_id                 :integer
#  transaction_id          :string
#  expiration_date         :datetime
#  amount                  :float
#  item_type               :string
#  created_at              :datetime
#  updated_at              :datetime
#  currency                :string
#  transaction_create_time :datetime
#  transaction_update_time :datetime
#  payment_method          :string
#  shipping_address        :string
#  transaction_status      :string
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#

class Payment < ActiveRecord::Base

  belongs_to :user

  attr_accessor :plan_id

  validates :plan_id, presence: true #, inclusion: { in: 0..1 }

  # Returns the payment URL to confirm the item
  def make_paypal_payment redirect_confirmed, redirect_denied
    @paypal_payment = PayPal::SDK::REST::Payment.new({
      :intent => "sale",
      # ###Payer
      :payer =>  {
        :payment_method => "paypal"
      },
      # ###Redirect URLs
      :redirect_urls => {
        :return_url => redirect_confirmed,
        :cancel_url => redirect_denied
      },
      # ###Transaction
      :transactions => [{
        # Item List
        :item_list => {
          :items => [{
            :name => "Rewardners month plan",
            :sku => "Rewardners month plan",
            :price => "5",
            :currency => "USD",
            :quantity => 1
          }]
        },
        # ###Amount
        :amount => {
          :total => "5",
          :currency => "USD"
        },
        :description => "Rewardners month plan"
      }]
    })
    if @paypal_payment.create
      self.update_attributes({
        transaction_id: @paypal_payment.id,
        amount: 5,
        currency: "USD",
        transaction_create_time: @paypal_payment.create_time,
        transaction_update_time: @paypal_payment.update_time,
        payment_method: :paypal,
        expiration_date: 30.days.from_now,
        item_type: self.plan_id,
        transaction_status: :created
      })
      @redirect_url = @paypal_payment.links.find{|v| v.method == "REDIRECT" }.href
      return @redirect_url
    else
      self.update_attributes({
        transaction_status: :error
      })
      return false
    end
  end

end
