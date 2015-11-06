# == Schema Information
#
# Table name: mentions
#
#  id               :integer          not null, primary key
#  mentioner_type   :string
#  mentioner_id     :integer
#  mentionable_type :string
#  mentionable_id   :integer
#  created_at       :datetime
#
# Indexes
#
#  fk_mentionables  (mentionable_id,mentionable_type)
#  fk_mentions      (mentioner_id,mentioner_type)
#

class Mention < Socialization::ActiveRecordStores::Mention
end
