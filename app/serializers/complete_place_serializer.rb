class CompletePlaceSerializer < ActiveModel::Serializer

  attributes :id, :name, :address, :phone, :email, :zipcode, :rewards_terms, :country, :city, :state, :likes

  def email
    object.user.email
  end

  def likes
    object.likers(User).count
  end

end
