module SearchPromos
  extend ActiveSupport::Concern

  included do

    scope :get_taken_promos_for_user, -> (user) {
      joins(:taken_promos).where(taken_promos: {approved_at: nil, rejected_at: nil, user: user})
    }

    scope :get_promos_by_zipcode, ->(zipcode) {
      includes(:place).joins(:place)
      .where("published = ? AND start_at <= ? ", 't', Time.now )
      .where(places: { zipcode: zipcode })
    }

    scope :get_promos_for_user, -> (user, search_active = false) {
      if search_active.present?
        includes(:place).joins(:place)
        .where("published = ? AND start_at <= ? ", 't', Time.now )
      else
        get_promos_by_zipcode(user.zipcode)
      end
      .where.not(places: {user_id: user.id})
      .where.not(id: get_taken_promos_for_user(user).pluck('promos.id'))
    }

    scope :get_promos_by_category, -> (category){
      joins(:subcategory_level1, :subcategory_level2)
      .where("promos.subcategory1_id = ? OR promos.subcategory2_id = ?", category, category)
    }

    scope :public_search, -> (search_params, category_param){
      if(category_param.present? && category_param > 0)
        includes(:place).joins(:place)
        .get_promos_by_category(category_param)
      else
        includes(:place).joins(:place)
      end
      .where("promos.published = ? AND promos.start_at <= ? AND (places.zipcode = ? OR places.name ILIKE ? OR places.city ILIKE ? )", 't', Time.now, search_params, "%#{search_params}%", "%#{search_params}%")
    }

    scope :search_user_promos, -> (user, search_params, category_param) {
      if(category_param.present? && category_param > 0)
        get_promos_for_user(user, search_params.present?)
        .get_promos_by_category(category_param)
      else
        get_promos_for_user(user, search_params.present?)
      end
      .where("promos.published = ? AND promos.start_at <= ? AND (places.zipcode = ? OR places.name ILIKE ? OR places.city ILIKE ? OR promos.name ILIKE ?)", 
        't', Time.now, search_params, "%#{search_params}%", "%#{search_params}%",  "%#{search_params}%")
    }
  end

end
