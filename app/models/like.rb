# == Schema Information
#
# Table name: likes
#
#  id            :integer          not null, primary key
#  liker_type    :string
#  liker_id      :integer
#  likeable_type :string
#  likeable_id   :integer
#  created_at    :datetime
#
# Indexes
#
#  fk_likeables  (likeable_id,likeable_type)
#  fk_likes      (liker_id,liker_type)
#

class Like < Socialization::ActiveRecordStores::Like
end
