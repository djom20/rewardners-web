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

class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :transaction_id, :purchased_at, :notification_params, :transaction_carrier, :expiration_date, :amount, :retention, :item_type, :status, :active_purchased
  has_one :user
end
