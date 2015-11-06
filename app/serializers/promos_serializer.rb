class PromosSerializer < ActiveModel::Serializer
  attributes :id, :description, :banner_thumb, :banner_medium, :name,
    :extra_description, :end_at
  has_one :place, embed: :object, include: true
  has_one :category, embed: :id, include: true

  def attributes
    hash = super
    if object.taken_by? current_user
      hash["promo_code"] = object.code_for? current_user
    end
    hash
  end

  def banner_thumb
    URI.join(ActionController::Base.asset_host || "", object.banner.url(:thumb)).to_s
  end

  def banner_medium
    URI.join(ActionController::Base.asset_host || "", object.banner.url(:medium)).to_s
  end

end
