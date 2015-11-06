# == Schema Information
#
# Table name: taken_promos
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  promo_id        :integer
#  created_at      :datetime
#  updated_at      :datetime
#  promo_code      :string
#  approved_at     :datetime
#  approved_by     :integer
#  rejected_at     :datetime
#  rejected_by     :integer
#  rejected_reason :text
#
# Indexes
#
#  index_taken_promos_on_promo_id  (promo_id)
#  index_taken_promos_on_user_id   (user_id)
#

class TakenPromo < ActiveRecord::Base
  include PublicActivity::Common

  before_create :generate_promo_code

  belongs_to :user
  belongs_to :promo
  has_one :approver, class_name: "User", foreign_key: :approved_by

  delegate :name, :star_number, to: :promo, prefix: true
  delegate :full_name_or_company, :email, to: :user, prefix: true

  # Obtener las promociones que han sido tomadas por los usuarios
  # en este caso usuario hace referencia al manager de los locales,
  # es decir este método busca todas las promociones para todos los locales
  # del usuario (user)
  scope :get_taken_promos_for_user_places, -> (user) {
    TakenPromo.includes(:user, promo: :place)
    .joins(:promo)
    .joins("INNER JOIN places ON promos.place_id = places.id")
    .where("places.user_id = ? ", user)
    .order("taken_promos.created_at desc")
  }

  scope :get_available_promos, -> {
    where.not(approved_at: nil, "taken_promos.id" => RedeemTakenPromo.pluck("taken_promo_id"))
  }

  # Get promotions taked by the user
  scope :get_taken_promos_for_user, -> (user) {
    TakenPromo.where({user_id: user})
    .order("created_at desc")
  }

  scope :get_available_taken_promos_for_user, -> (user) {
    TakenPromo.get_taken_promos_for_user(user).merge(TakenPromo.get_available_promos)
  }

  def accept user
    self.approved_by = user.id
    self.approved_at = Time.now
    self.save
  end

  def reject user
    self.rejected_by = user.id
    self.rejected_at = Time.now
    self.save
  end

  def approved?
    self.approved_at != nil
  end

  def rejected?
    self.rejected_at != nil
  end

  def order_status?
    if approved_at.present?
      "approved"
    elsif rejected_at.present?
      "rejected"
    else
      "waiting"
    end
  end

  def created_at_formatted
    created_at.strftime("%d/%m/%Y %r")
  end

  private

  def generate_promo_code
    self.promo_code = CouponCode.generate
  end

end
