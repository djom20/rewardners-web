# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  zipcode                :string
#  name                   :string
#  last_name              :string
#  business_name          :string
#  address                :string
#  city                   :string
#  manager                :string
#  phone                  :string
#  authentication_token   :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  search_code            :string
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

class User < ActiveRecord::Base
  include PublicActivity::Common

  rolify
  acts_as_liker

  before_create :set_user_role
  before_create :generate_search_code
  after_create :set_default_subscription

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :signup_type, :terms

  has_many :subscriptions
  has_many :payments
  has_many :places
  has_many :redeems
  has_many :taken_promos
  has_many :promos, through: :taken_promos
  has_many :favorites
  has_many :promos, through: :favorites, as: :likes
  has_many :promos, through: :places

  # has_many :promos_createad, class_name: "Promo", foreign_key: "user_id", dependent: :destroy

  # Paperclip
  has_attached_file :avatar, styles: {
    medium: "300x300>",
    thumb: "100x100>"
  }, default_url: "no-avatar.png"

  validates :signup_type, presence: true, inclusion: %w(business default_user), on: :create
  validates :city, presence: true

  validates :address, presence: true
  validates :zipcode, presence: true
  validates_format_of :zipcode, with: /\A\d{5}-\d{4}|\A\d{5}\z/, message: I18n.t('activerecord.validations.user.zipcode.message')
  validates_acceptance_of :terms

  validates_attachment_size :avatar, less_than: 5.megabytes
  validates_attachment_content_type :avatar, content_type: /^image\/(png|jpeg|jpg)/

  # Validaciones para usuarios
  validates :name, presence: true, if: :is_default_user?
  validates :last_name, presence: true, if: :is_default_user?

  # Validaciones para usuarios negocios
  validates :business_name, presence: true, if: :is_business_user?
  validates :manager, presence: true, if: :is_business_user?

  def role?
    roles.first
  end

  def valid_program?
    @payment = self.payments.where(transaction_status: :approved).first
    if @payment
      hours =  ((Time.now - @payment.expiration_date) / 1.minute)
      if hours <= 0.0
        return true
      end
    end
    return false
  end

  def full_name_or_company
    if self.has_role? :business
      return self.business_name
    end
    return "#{name} #{last_name}".titleize
  end

  def generate_auth_token!
    salt = BCrypt::Engine.generate_salt
    self.update_attribute :authentication_token, BCrypt::Engine.hash_secret(SecureRandom.hex, salt)
  end

  def remove_auth_token!
    self.update_attribute :authentication_token, nil
  end

  def role_name
    roles.first.name
  end

  def role_name_formatted
    I18n.t("roles.#{role_name}")
  end

  def favorite_places
    Place.get_liked_places_for_user(self.id)
  end

  def default_user?
    has_role? :default_user
  end

  def business_user?
    has_role? :business
  end

  def admin_user?
    has_role? :administrator
  end

  def has_a_free_subscription_active?
    subscriptions.where(free: true, canceled: false, deleted_at: nil).present?
  end

  def has_a_subscription_payed_active?
    subscriptions.where("canceled = 'f' AND deleted_at IS NULL AND paid_until IS NOT NULL AND paid_until >= ?", Time.now).last.present?
  end

  def cancel_default_subscription
    default_subscription = subscriptions.where(free: true, canceled: false, deleted_at: nil).first
    default_subscription.update_attributes(canceled: true) if default_subscription.present?
  end

  def add_default_subscription
    default_subscription = subscriptions.where(free: true, canceled: true, deleted_at: nil).first
    default_subscription.update_attributes(canceled: false) if default_subscription.present?
  end

  def plan_active plan_id
    subscriptions.where(plan_id: plan_id, canceled: false, deleted_at: nil).first
  end

  def has_promos_in_current_month
    promos.where("promos.created_at >= ? AND promos.created_at <= ?", Time.now.beginning_of_month, Time.now.end_of_month).count == 0
  end

  def can_create_promos?
    has_a_free_subscription_active? ? has_promos_in_current_month : true
  end

  def current_subscription
    subscriptions.where("canceled = 'f' AND deleted_at IS NULL AND paid_until IS NOT NULL AND paid_until >= ?", Time.now).first
  end

  def can_take_promo?(promo_id)
    promos.find_by_id(promo_id).present? ?  false : true
  end

  def can_like_place?(place_id)
    places.find_by_id(place_id).present? ? false : true
  end

  private

    def set_user_role
      case signup_type
      when "default_user"
        add_role :default_user
      when "business"
        add_role :business
      when "administrator"
        add_role :administrator
      end
    end

    def set_default_subscription
      Subscription.create(plan_id: 1, user_id: self.id, free: true) if self.business_user?
    end

    def is_business_user?
      signup_type.present? ? signup_type.eql?("business") : business_user?
    end

    def is_default_user?
      signup_type.present? ? signup_type.eql?("default_user") : default_user?
    end

    def generate_search_code
      self.search_code = CouponCode.generate
    end

end
