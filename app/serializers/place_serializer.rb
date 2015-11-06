# == Schema Information
#
# Table name: places
#
#  id                  :integer          not null, primary key
#  name                :string
#  address             :string
#  phone               :string
#  user_id             :integer
#  created_at          :datetime
#  updated_at          :datetime
#  zipcode             :string
#  email               :string
#  rewards_terms       :text
#  country             :string
#  city                :string
#  state               :string
#  latitude            :float
#  longitude           :float
#  banner_file_name    :string
#  banner_content_type :string
#  banner_file_size    :integer
#  banner_updated_at   :datetime
#  logo_file_name      :string
#  logo_content_type   :string
#  logo_file_size      :integer
#  logo_updated_at     :datetime
#
# Indexes
#
#  index_places_on_user_id  (user_id)
#

class PlaceSerializer < ActiveModel::Serializer

  attributes :id, :name, :address, :phone, :email, :liked_by_user, :likes,
    :logo_thumb, :logo_medium, :banner_thumb, :banner_medium, :user_id

  def email
    object.user.email
  end

  def liked_by_user
    current_user.likes? object
  end

  def likes
    object.likers(User).count
  end

  def stars
    unless object.stars.nil?
      object.stars
    end
  end

  def logo_thumb
    URI.join(ActionController::Base.asset_host || "", object.logo.url(:thumb)).to_s
  end

  def logo_medium
    URI.join(ActionController::Base.asset_host || "", object.logo.url(:medium)).to_s
  end

   def banner_thumb
    URI.join(ActionController::Base.asset_host || "", object.banner.url(:thumb)).to_s
  end

  def banner_medium
    URI.join(ActionController::Base.asset_host || "", object.banner.url(:medium)).to_s
  end

end
