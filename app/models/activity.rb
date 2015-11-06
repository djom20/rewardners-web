# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  trackable_id   :integer
#  trackable_type :string
#  owner_id       :integer
#  owner_type     :string
#  key            :string
#  parameters     :text
#  recipient_id   :integer
#  recipient_type :string
#  created_at     :datetime
#  updated_at     :datetime
#  status         :string           default("no_viewed")
#
# Indexes
#
#  index_activities_on_owner_id_and_owner_type          (owner_id,owner_type)
#  index_activities_on_recipient_id_and_recipient_type  (recipient_id,recipient_type)
#  index_activities_on_trackable_id_and_trackable_type  (trackable_id,trackable_type)
#

class Activity < ActiveRecord::Base
  VIEWED = "viewed"
  NO_VIEWED = "no_viewed"
  STATUS = [VIEWED, NO_VIEWED]

  # def owner_name
  #   User.find(owner_id).full_name_or_company
  # end

  # def recipient_name
  #   User.find(recipient_id).full_name_or_company
  # end

  # def time
  #   days = (Date.current - created_at.to_date).to_i
  #   (days > 0 ? I18n.t('notifications.time.days', days) : I18n.t('notifications.time.today'))
  # end

end
