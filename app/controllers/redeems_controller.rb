class RedeemsController < ApplicationController

  before_action :set_place, only: [:new]
  before_action :set_user, only: [:new]
  before_action :set_redeem, only: [:new]
  before_action :set_new_redeem, only: [:create]

  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    @redeems = Redeem.get_redeems_for_locals_with_user(current_user)
  end

  def processed
    @redeems = Redeem.get_redeems_for_user(current_user).paginate(page: params[:page], per_page: 10)
  end

  def new
    respond_to do |format|
      if @place.nil? || @user.nil?
        format.html { redirect_to delivery_redeems_path, alert: 'Invalid action.' }
      else
        format.html { }
      end
    end
  end

  def create
    respond_to do |format|
      if @redeem.save
        @redeem.create_activity :create, owner: current_user, recipient: @redeem.user
        format.html { redirect_to delivery_redeems_path, notice: I18n.t('controllers.redeems.create') }
      else
        format.html { render :new }
      end
    end
  end

  def delivery
    respond_to do |format|
      @places = Place.get_available_stars_for_places_for_user(current_user).to_a.paginate(page: params[:page], per_page: 10)
      format.html { }
    end
  end

  def destroy
    @redeem = Redeem.find(params[:id])
    respond_to do |format|
      unless @redeem.nil?
        if current_user.places.where(id: @redeem.place_id)
          @redeem.destroy
          format.html { redirect_to redeems_path, notice: I18n.t('controllers.redeems.destroy') }
        else
          format.html { redirect_to redeems_path, alert: I18n.t('controllers.redeems.no_destroy') }
        end
      else
        format.html { redirect_to redeems_path, alert: I18n.t('controllers.redeems.no_destroy') }
      end
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_redeem
    @redeem = Redeem.new
    @redeem.user = @user
    @redeem.place = @place
  end

  def set_new_redeem
    @redeem = Redeem.new redeem_params
    @redeem.approved_by = current_user.id
    @redeem.approved_at = Time.now
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def redeem_params
    params.require(:redeem).permit(:description, :number_of_stars, :user_id, :place_id)
  end

end
