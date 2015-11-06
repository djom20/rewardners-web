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

class Place < ActiveRecord::Base
  include PublicActivity::Common
  include QueryPlaces

  acts_as_likeable
  phony_normalize :phone, default_country_code: 'US'

  # belongs_to :category
  belongs_to :user
  has_many :promos, dependent: :destroy

  # Paperclip
  has_attached_file :banner, styles: {
    full: "1000x300#",
    medium: "300x300>",
    thumb: "100x100>"
  }, default_url: "banner_default.png"

  has_attached_file :logo, styles: {
    medium: "300x300>",
    thumb: "100x100>"
  }, default_url: "default-logo.png"

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :phone, presence: true
  validates_plausible_phone :phone, presence: true
  validates :email, presence: true, allow_blank: true
  validates :city, presence: true, allow_blank: true
  validates :state, presence: true, allow_blank: true
  validates :country, presence: true, allow_blank: true
  validates :rewards_terms, presence: true, allow_blank: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :banner, presence: true
  validates :logo, presence: true
  validates_format_of :zipcode, with: /\A\d{5}-\d{4}|\A\d{5}\z/, message: I18n.t('activerecord.validations.user.zipcode.message')

  validates_attachment_size :banner, less_than: 5.megabytes
  validates_attachment_content_type :banner, content_type: /^image\/(png|jpeg|jpg)/
  validates_presence_of :banner, :message => "choose the file!"

  validates_attachment_size :logo, less_than: 5.megabytes
  validates_attachment_content_type :logo, content_type: /^image\/(png|jpeg|jpg)/
  validates_presence_of :banner, :message => "choose the file!"

  delegate :email, :name, to: :user, prefix: true

  scope :find_for_user_with_criteria, -> (user, criteria) {
    where("name ILIKE ?", "%#{criteria}%")
    .where(zipcode: user.zipcode)
    .order("created_at desc")
  }

  def compose_address
    "#{country}, #{city}, #{state} #{address}"
  end

end
