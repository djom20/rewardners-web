# == Schema Information
#
# Table name: subscriptions
#
#  id                :integer          not null, primary key
#  paypal_payer_id   :string
#  paypal_profile_id :string
#  plan_id           :integer
#  user_id           :integer
#  paid_until        :datetime
#  canceled          :boolean          default(FALSE)
#  free              :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  deleted_at        :datetime
#
# Indexes
#
#  index_subscriptions_on_deleted_at  (deleted_at)
#  index_subscriptions_on_plan_id     (plan_id)
#  index_subscriptions_on_user_id     (user_id)
#

class Subscription < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :plan
  belongs_to :user

  validates :plan_id, presence: true
  validates :paypal_payer_id, uniqueness: { scope: :user_id }, if: Proc.new { |s| s.paypal_payer_id.present? }
  validates :paypal_profile_id, uniqueness: { scope: [:paypal_payer_id, :user_id] }, if: Proc.new { |s| s.paypal_payer_id.present? }

  delegate :name_es, :name_en, :price, :paypal_description_es, :paypal_description_en, to: :plan, prefix: true

  def plan_name_I18n locale
    locale = locale.present? ? locale : "en"
    eval("plan_name_#{locale}")
  end

  def plan_paypal_description_I18n locale
    locale = locale.present? ? locale : "en"
    eval("plan_paypal_description_#{locale}")
  end

  def cancel!
    update_attributes(cancel: true)
  end

  def created_at_formatted
    created_at.strftime("%d/%m/%Y %r")
  end

  def paid_until_formatted
    paid_until.strftime("%d/%m/%Y %r")
  end

  def not_canceled?
    !canceled
  end

  def is_free?
    free
  end

  def status?
    is_free? ? not_canceled? : (not_canceled? && paid?)
  end

  def status_I18n
    I18n.t("activerecord.attributes.subscription.status.#{status?}")
  end

  def paid?
    return false if paid_until.blank?
    paid_until >= Time.now
  end

end
