# == Schema Information
#
# Table name: follows
#
#  id              :integer          not null, primary key
#  follower_type   :string
#  follower_id     :integer
#  followable_type :string
#  followable_id   :integer
#  created_at      :datetime
#
# Indexes
#
#  fk_followables  (followable_id,followable_type)
#  fk_follows      (follower_id,follower_type)
#

class Follow < Socialization::ActiveRecordStores::Follow
end
