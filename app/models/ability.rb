class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :business
      can :manage, Place, user_id: user.id
      can [:info], Place
      can :manage, Promo
      can :manage, Subscription
      if user.has_a_subscription_payed_active?
        can :manage, Redeem
        can :manage, TakenPromo
      else
        can [:processed], Redeem
      end
      can [:index, :show, :create, :confirmation_status], Payment
      can [:favorite_places, :taken_promos], User
      can [:subcategories], Category
    elsif user.has_role? :default_user
        can [:trendings, :taken_promos, :processed_promos, :take, :untake, :search, :favorites, :public_search, :show], Promo
        can [:discover, :like, :unlike, :stars, :info, :show], Place
        can [:processed], Redeem
        can :manage, Category
        can [:favorite_places, :taken_promos], User
    else
      can [:info], Place
      can [:public_search, :show], Promo
    end
  end
end
