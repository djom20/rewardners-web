# == Schema Information
#
# Table name: redeems
#
#  id              :integer          not null, primary key
#  approved_by     :integer
#  user_id         :integer
#  place_id        :integer
#  description     :text
#  approved_at     :datetime
#  rejected_at     :datetime
#  rejected_by     :integer
#  rejected_reason :text
#  created_at      :datetime
#  updated_at      :datetime
#  number_of_stars :integer
#
# Indexes
#
#  index_redeems_on_place_id  (place_id)
#  index_redeems_on_user_id   (user_id)
#

class RedeemSerializer < ActiveModel::Serializer
  attributes :approved_by, :user_id, :place_id, :description, :approved_at,
    :rejected_at, :rejected_by, :rejected_reason, :number_of_stars
  has_one :place, embed: :object, serializer: PlaceSerializer
  has_one :user, embed: :object, serializer: UserSerializer

end
