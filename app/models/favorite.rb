class Favorite < ActiveRecord::Base

  include PublicActivity::Common

  belongs_to :user
  belongs_to :place

end
