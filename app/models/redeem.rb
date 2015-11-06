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

class Redeem < ActiveRecord::Base
  include PublicActivity::Common

  before_create :set_promos

  belongs_to :user
  belongs_to :place

  belongs_to :approver, class_name: "User", foreign_key: :approved_by

  has_many :redeem_taken_promos
  has_many :taken_promos, through: :redeem_taken_promos, dependent: :destroy

  validates :description, presence: true
  validates :number_of_stars, presence: true, numericality: { only_integer: true }
  validates :user, presence: true
  validates :place, presence: true
  validate :valid_place_with_user?
  validate :validates_number_of_stars, if: 'number_of_stars.present?'

  delegate :name, to: :place, prefix: true

  scope :get_total_available_stars_with_places_and_user, -> (place_id, user_id) {

    current_redeem = Redeem.select("SUM(number_of_stars) as stars")
          .where("place_id = ? AND user_id = ?", place_id, user_id)
          .group(:place_id, :user_id)[0]
    redeem_stars = current_redeem.blank? ? 0 : current_redeem.stars

    taken_promos = TakenPromo.select("SUM(promos.star_number) as stars")
    .joins(:promo).where("taken_promos.user_id = ? AND promos.place_id = ?", user_id, place_id)
    .group("taken_promos.user_id")[0]

    result =  taken_promos.stars - redeem_stars
  }

  scope :get_redeems_for_locals_with_user, -> (user) {
    where(place_id: user.places.pluck(:id))
  }

  scope :get_redeems_for_user, -> (user_id) {
    includes(:place).where(user_id: user_id)
  }

  def approved?
    self.approved_at != nil
  end

  def rejected?
    self.rejected_at != nil
  end

  def approved_at_formatted
    approved_at.strftime("%d/%m/%Y %r")
  end

  def total_stars
    Redeem.get_total_available_stars_with_places_and_user(place, user)
  end

  protected

  def validates_number_of_stars
    if number_of_stars > total_stars
      errors.add(:number_of_stars, I18n.t('activerecord.validations.redeem.number_of_stars_greater'))
    elsif number_of_stars <= 0
      errors.add(:number_of_stars, I18n.t('activerecord.validations.redeem.number_of_stars_cero'))
    end
  end

  def valid_place_with_user?
    result = User.where(id: TakenPromo.joins(:promo).where("taken_promos.user_id" => user, "promos.place_id" => place).pluck("taken_promos.user_id").first).first
    if result.nil?
      errors.add(:base, "Invalid user place")
    end
  end

  # def validates_place
  #   place = current_user.places.where(place).first
  #   if place.nil?
  #     errors.add(:place, "invalid place")
  #   end
  # end
  #
  # def validates_user
  #   user = User.where(id: TakenPromo.joins(:promo)
  #     .where(user_id: user, "promos.place_id" => place)
  #     .pluck("taken_promos.user_id").first).first.nil?
  #   if user.nil?
  #     errors.add(:user, "invalid user")
  #   end
  # end

  def set_promos
    self.taken_promos << TakenPromo.joins(:promo).merge(TakenPromo.get_available_taken_promos_for_user(user)).
    where("promos.place_id" => place).limit(number_of_stars)
  end

end
