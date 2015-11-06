# == Schema Information
#
# Table name: redeem_taken_promos
#
#  id             :integer          not null, primary key
#  taken_promo_id :integer
#  redeem_id      :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_redeem_taken_promos_on_redeem_id       (redeem_id)
#  index_redeem_taken_promos_on_taken_promo_id  (taken_promo_id)
#

class RedeemTakenPromo < ActiveRecord::Base

  belongs_to :taken_promo
  belongs_to :redeem

end
