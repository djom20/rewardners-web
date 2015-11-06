class PlacesController < ApplicationController

  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:info]
  load_and_authorize_resource

  def index
    @places = current_user.places.paginate(page: params[:page], per_page: 10)
  end

  def new
    @place = current_user.places.new
  end

  def create
    @place = current_user.places.new(place_params)
    if @place.save
      redirect_to places_path, notice: I18n.t('controllers.places.create')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @place.update(place_params)
      redirect_to place_path(@place), notice: I18n.t('controllers.places.update')
    else
      render :edit
    end
  end

  def show
  end

  def info
    @place = Place.find_by(id: place_param_id[:id])
  end

  # DELETE /places/1
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: I18n.t('controllers.places.destroy') }
    end
  end

  def discover
    @places = Place.find_for_user_with_criteria(current_user, params[:criteria]).paginate(per_page: params[:per_page], page: params[:page])
    respond_to do |format|
      format.html {}
    end
  end

  # Obtiene todas las promociones tomadas y el número de estrellas que representa
  def stars
    respond_to do |format|
      @places = Place.get_available_stars_for_user(current_user).to_a.paginate(page: params[:page], per_page: 10)
      format.html
    end
  end

  # < Favorites >
  def like
    respond_to do |format|
      current_user.like!(@place)
      @place.create_activity :like, owner: current_user, recipient: @place.user
      format.js { render partial: "places/like_unlike/update_like_unlike_actions", locals: { place: @place} }
    end
  end

  def unlike
    respond_to do |format|
      current_user.unlike!(@place)
      @place.create_activity :unlike, owner: current_user, recipient: @place.user
      format.js { render partial: "places/like_unlike/update_like_unlike_actions", locals: {place: @place} }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_place
    @place = current_user.places.find_by(id: place_param_id[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def place_params
    params.require(:place).permit(:name, :address, :phone, :email, :zipcode, :city, :state, :country, :rewards_terms, :latitude, :longitude, :logo, :banner)
  end

  def place_param_id
    params.permit(:id)
  end

end
