# == Schema Information
#
# Table name: promos
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :text
#  place_id            :integer
#  published           :boolean
#  published_at        :datetime
#  role_id             :integer
#  start_at            :datetime
#  end_at              :datetime
#  extra_description   :text
#  created_at          :datetime
#  updated_at          :datetime
#  banner_file_name    :string
#  banner_content_type :string
#  banner_file_size    :integer
#  banner_updated_at   :datetime
#  unpublished_at      :datetime
#  category_id         :integer
#  star_number         :integer          default(1)
#  subcategory1_id     :integer
#  subcategory2_id     :integer
#
# Indexes
#
#  index_promos_on_category_id  (category_id)
#  index_promos_on_place_id     (place_id)
#  index_promos_on_role_id      (role_id)
#

class Promo < ActiveRecord::Base
  include SearchPromos
  include PublicActivity::Common

  belongs_to :place
  belongs_to :role

  has_one :category_root, class_name: "Category", foreign_key: :category_id
  has_one :subcategory_level1, class_name: "Category", foreign_key: :subcategory1_id
  has_one :subcategory_level2, class_name: "Category", foreign_key: :subcategory2_id

  # To get taken promo users
  has_many :taken_promos
  has_many :users, through: :taken_promos

  belongs_to :category, class_name: "Category", foreign_key: :category_id
  belongs_to :subcategory_level1, class_name: "Category", foreign_key: :subcategory1_id
  belongs_to :subcategory_level2, class_name: "Category", foreign_key: :subcategory2_id

  # Paperclip
  has_attached_file :banner, styles: {
    medium: "300x300>",
    thumb: "100x100>"
  },
  default_url: "promo_default.png"

  attr_accessor :created_via_api

  validates_attachment_size :banner, less_than: 5.megabytes
  validates_attachment_content_type :banner, content_type: /^image\/(png|jpeg|jpg)/

  validates :banner, presence: true, if: "!created_via_api"
  validates :description, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :published, presence: true, allow_blank: true, on: :update
  validates :role_id, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :star_number, presence: true
  validates :category_id, presence: true
  validates :subcategory1_id, presence: true

  # validate :free_promo_range_start_at
  # validate :free_promo_range_end_at

  delegate :name, to: :place, prefix: true
  delegate :name, to: :role, prefix: true, allow_nil: true
  delegate :zipcode, to: :place, prefix: true
  delegate :city, to: :place, prefix: true
  delegate :user, to: :place, allow_nil: true
  delegate :id, to: :place, prefix: true

  # ~~.Scopes

  scope :get_promo, -> (id) {
    where(published: true, id: id).first
  }

  scope :get_promos_for_user_with_filters, -> (user, categories, criteria) {
    Promo.get_promos_for_user(user)
    .joins(:categories)
    .where(:"categories.id" => categories)
    .where("promos.name ILIKE ? or places.address ILIKE ? or places.phone ILIKE ? or promos.description ILIKE ?", "%#{criteria}%", "%#{criteria}%", "%#{criteria}%", "%#{criteria}%")
    .group("promos.id")
  }

  scope :get_promos_based_on_liked_places_for_user, -> (user) {
    joins(:place)
    .where(:place_id => Place.get_liked_places_for_user(user.id))
    .where(published: true)
    .where.not(places: {user_id: user.id})
    .where.not(id: Promo.get_taken_promos_for_user(user).pluck('promos.id'))
  }

  before_create :assign_published_date
  before_update :check_for_published

  # return if user taken this promo
  def taken_by? user
    TakenPromo.where(approved_at: nil, rejected_at: nil, user: user, promo: self).exists?
  end

  def code_for? user
    TakenPromo.where(user: user, promo: self).pluck(:promo_code)[0]
  end

  def take_promo! current_user
    unless taken_by? current_user
      @taken_promo = current_user.taken_promos.new(promo: self)
      if @taken_promo.save
        @taken_promo.create_activity :take, owner: current_user, recipient: self.user
      end
      return @taken_promo
    end
    return false
  end

  def untake_promo! current_user
    if taken_by? current_user
      @taken_promo = current_user.taken_promos.where(promo_id: self, approved_at: nil).first
      @taken_promo.create_activity :untake, owner: current_user, recipient: self.user
      return @taken_promo.destroy
    end
    return false
  end

  def published?
    I18n.t("activerecord.attributes.promo.published_status.#{published}")
  end

  def published_at_formatted
    published_at.present? ? published_at.strftime("%d/%m/%Y %r") : nil
  end

  def role_name_formatted
    I18n.t("roles.#{role_name}")
  end

  def created_at_formatted
    created_at.strftime("%d/%m/%Y %r")
  end

  def categories_selected locale
    locale = locale.present? ? locale : "en"
    categories = [category_name(category_id, locale),category_name(subcategory1_id, locale), category_name(subcategory2_id, locale) ]
    categories.join(" - ")
  end

  def category_name category_id, locale
    Category.find(category_id).name_I18n(locale) if category_id && Category.find(category_id).present?
  end

  private

    def free_promo_range_start_at
      if self.start_at.present?
        if self.start_at < Time.now.beginning_of_month || self.start_at > Time.now.end_of_month
          errors.add(:start_at, I18n.t('activerecord.validations.promo.start_at.per_month'))
        end
      end
    end

    def free_promo_range_end_at
      if self.end_at.present?
        if self.end_at < Time.now.beginning_of_month || self.end_at > Time.now.end_of_month
          errors.add(:end_at, I18n.t('activerecord.validations.promo.end_at.per_month'))
        end
      end
    end

  protected

    def assign_published_date
      if self.new_record? && self.published
        self.published_at = Time.now
      end
    end

    def check_for_published
      unless self.new_record?
        self.published_at = self.published ? Time.new : nil
        self.unpublished_at = self.published ? nil : Time.new
      end
    end

end
