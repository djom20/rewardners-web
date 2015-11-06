class UsersController < ApplicationController

  load_and_authorize_resource except: [:show, :welcome]

  def welcome
  end

  def show
    @user = current_user
  end

  def favorite_places
    @places = current_user.favorite_places.includes(:user).paginate(page: params[:page], per_page: 10)
  end

  def taken_promos
    @promos = current_user.taken_promos.includes(:promo).paginate(page: params[:page], per_page: 10)
  end

end
