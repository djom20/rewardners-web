module QueryPlaces
  extend ActiveSupport::Concern

  included do
    scope :get_liked_places_for_user, ->(user_id) {
      joins("INNER JOIN likes ON likes.likeable_id = places.id")
      .where("likes.liker_id = #{user_id}")
      .group("places.id, likes.created_at")
    }

    scope :get_available_stars_for_user, -> (user_id) {

      subquery1 = TakenPromo.includes(:user)
                            .select("places.id, places.name, taken_promos.user_id, SUM(promos.star_number) as stars")
                            .joins(:promo)
                            .joins("INNER JOIN places ON promos.place_id = places.id")
                            .where("taken_promos.user_id = ?", user_id)
                            .group(:"places.id", :"taken_promos.user_id")

      subquery2 = Redeem.select("SUM(number_of_stars) as stars, place_id, user_id")
                        .group(:place_id, :user_id)

      query = " SELECT T1.id as place_id, T1.name, COALESCE((T1.stars - COALESCE(T2.stars, 0)), 0) as total_stars
                FROM (#{subquery1.to_sql}) as T1
                LEFT JOIN (#{subquery2.to_sql}) as T2
                ON (T1.id = T2.place_id AND T1.user_id = T2.user_id)
                WHERE COALESCE((T1.stars - COALESCE(T2.stars, 0)), 0) != 0
                ORDER BY T1.name"

      ActiveRecord::Base.connection.execute(query)
    }

    scope :get_available_stars_for_places_for_user, -> (user_id, pending_user_code = nil) {

      subquery1 = TakenPromo.includes(:user)
                            .select("places.id, places.name, SUM(promos.star_number) as stars, taken_promos.user_id, users.name as user_name, users.email as user_email, users.last_name as user_last_name, users.business_name as user_business_name")
                            .joins(:promo)
                            .joins("INNER JOIN places ON promos.place_id = places.id")
                            .joins("INNER JOIN users ON users.id = taken_promos.user_id")
                            .where("places.user_id = ?", user_id)
                            .where("taken_promos.approved_at IS NOT NULL")
                            .group(:"places.id", :"taken_promos.user_id", :"users.email", :"users.name", :"users.last_name", :"users.business_name")

      if pending_user_code.present?
        subquery1 = subquery1.where("users.search_code = ?", pending_user_code)
      end

      subquery2 = Redeem.select("SUM(number_of_stars) as stars, place_id, user_id")
                        .group(:place_id, :user_id)

      query = " SELECT T1.id as place_id, T1.user_id, T1.name, T1.user_name, T1.user_last_name, T1.user_business_name, T1.user_email, T1.user_id, T1.stars as current_stars, COALESCE(T2.stars, 0) as taken_stars, COALESCE((T1.stars - COALESCE(T2.stars, 0)), 0) as total_stars
                FROM (#{subquery1.to_sql}) as T1
                LEFT JOIN (#{subquery2.to_sql}) as T2
                ON (T1.id = T2.place_id AND T1.user_id = T2.user_id)
                WHERE COALESCE((T1.stars - COALESCE(T2.stars, 0)), 0) != 0
                ORDER BY T1.name"

      ActiveRecord::Base.connection.execute(query)
    }

  end

end
