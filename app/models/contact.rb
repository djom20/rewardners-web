class Contact
  include ActiveModel::Model

  attr_accessor :name, :email, :message_title, :message_body

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: I18n.t('activerecord.validations.contacts.email') }
  validates :message_title, presence: true
  validates :message_body, presence: true

end
