# == Schema Information
#
# Table name: taken_promos
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  promo_id        :integer
#  created_at      :datetime
#  updated_at      :datetime
#  promo_code      :string
#  approved_at     :datetime
#  approved_by     :integer
#  rejected_at     :datetime
#  rejected_by     :integer
#  rejected_reason :text
#
# Indexes
#
#  index_taken_promos_on_promo_id  (promo_id)
#  index_taken_promos_on_user_id   (user_id)
#

class TakenPromoSerializer < ActiveModel::Serializer

  include ActionView::Helpers::DateHelper

  attributes :id, :promo_code, :status, :date, :approved_at, :rejected_at
  has_one :promo, embed: :object, serializer: PromosSerializer
  has_one :user, embed: :object, serializer: UserSerializer

  def status
    if object.approved?
      :approved
    elsif object.rejected?
      :rejected
    else
      :waiting_approvation
    end
  end

  def date
    if object.approved?
      time_ago_in_words object.approved_at
    elsif object.rejected?
      time_ago_in_words object.rejected_at
    else
      nil
    end
  end

end
