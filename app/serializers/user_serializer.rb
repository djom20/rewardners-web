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

class UserSerializer < ActiveModel::Serializer

  attributes :id, :full_name, :email, :city, :manager, :role, :roles, :search_code, 
    :name, :last_name, :zipcode, :phone, :address

  def full_name
    object.full_name_or_company
  end

  def role
    object.role?.name
  end

  def roles
    object.roles.map(&:name)
  end


end
