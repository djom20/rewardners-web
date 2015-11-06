# == Schema Information
#
# Table name: plans
#
#  id                    :integer          not null, primary key
#  name_es               :string
#  name_en               :string
#  price                 :float
#  description_es        :text
#  description_en        :text
#  paypal_description_es :string
#  paypal_description_en :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Plan < ActiveRecord::Base

  validates :name_es, presence: true
  validates :name_en, presence: true
  validates :price, presence: true
  validates :description_es, presence: true
  validates :description_en, presence: true
  validates :paypal_description_es, presence: true
  validates :paypal_description_en, presence: true

  def name_I18n locale
    locale = locale.present? ? locale : "en"
    eval("name_#{locale}")
  end

  def description_I18n locale
    locale = locale.present? ? locale : "en"
    eval("description_#{locale}")
  end

  def paypal_description_I18n locale
    locale = locale.present? ? locale : "en"
    eval("paypal_description_#{locale}")
  end

end
