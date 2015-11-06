class PromosController < ApplicationController

  before_action :set_place, except: [:trendings, :taken_promos, :processed_promos, :search, :favorites, :public_search]
  before_action :set_promo, only: [:show, :edit, :update, :destroy, :take, :untake]
  before_action :set_roles, only: [:new, :edit]
  before_action :authenticate_user!, except: [:public_search, :show]

  load_and_authorize_resource

  def index
    @promos = @place.promos.all.includes(:role).paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @promo = @place.promos.new
    load_categories
  end

  def edit
    load_categories
  end

  def create
    unless current_user.can_create_promos?
      redirect_to place_promos_path(@place), notice: I18n.t('controllers.promos.free_plan_restriction')
    end
    @promo = @place.promos.new(promo_params)
    if @promo.save
      redirect_to place_promos_path(@place), notice: I18n.t('controllers.promos.create')
    else
      @roles = Role.business_user_roles
      @root_categories = Category.root_categories

      @sub_categories = if params[:subcategory1_id].present?
        subcategory1_parent_id = Category.find(params[:subcategory1_id]).parent_id
        Category.find(subcategory1_parent_id).subcategories
      else
        Category.sub_categories(2)
      end

      @sub_categories_two = if params[:subcategory2_id].present?
        subcategory2_parent_id = Category.find(params[:subcategory2_id]).parent_id
        Category.find(subcategory2_parent_id).subcategories
      else
        Category.sub_categories(3)
      end

      render :new
    end
  end

  def update
    if @promo.update(promo_params)
      redirect_to place_promos_path(@place), notice: I18n.t('controllers.promos.update')
    else
      render :edit
    end
  end

  def destroy
    @promo.destroy
    redirect_to place_promos_path(@place), notice: I18n.t('controllers.promos.destroy')
  end

  # Customs

  # < Promos >

  # Resumen de promociones tomadas por un cliente
  def processed_promos
    respond_to do |format|
      @taken_promos = TakenPromo.get_taken_promos_for_user current_user
      format.html {  }
    end
  end

  # Las promociones tomadas, que no ha tenido una respuesta del local.
  def taken_promos
    respond_to do |format|
      @promos = Promo.get_taken_promos_for_user current_user
      format.html { render "promos/content" }
    end
  end

  # Las promociones vigentes para el usuario, son publicaciones que estén activas
  # y no tenga solicitudes pendientes.
  def trendings
    respond_to do |format|
      @promos = Promo.get_promos_for_user current_user
      format.html { render "promos/content" }
    end
  end

  def search
    search_params = params[:search].present? ? params[:search].downcase : ""
    category_param = params[:category].present? ? params[:category].to_i : 0

    @categories = Category.includes(:subcategories).root_categories
    @promos = Promo.search_user_promos(current_user, search_params, category_param).order(created_at: :desc).paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html { render "promos/content" }
      format.js { render "promos/content" }
    end
  end

  def public_search
    search_params = params[:search].present? ? params[:search].downcase : ""
    category_param = params[:category].present? ? params[:category].to_i : 0

    @categories = Category.includes(:subcategories).root_categories
    @promos = Promo.public_search(search_params, category_param).order(created_at: :desc).paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html { render "promos/content" }
      format.js { render "promos/content" }
    end
  end

  def favorites
    @promos = Promo.get_promos_based_on_liked_places_for_user current_user
    respond_to do |format|
      format.html { }
    end
  end

  # Tomar promoción para un usuario
  def take
    respond_to do |format|
      unless @promo.take_promo! current_user
        format.js { render partial: "promos/promo/update_take_untake_button", locals: { promo: @promo } }
      else
        format.js {}
      end
    end
  end

  # Cancelar una promoción para un usuario
  def untake
    respond_to do |format|
      if @promo.untake_promo! current_user
        format.js { render partial: "promos/promo/update_take_untake_button", locals: { promo: @promo } }
      else
        format.js {}
      end
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def set_roles
    @roles = Role.business_user_roles
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_promo
    @promo = @place.promos.find(params[:id])
  end

  def load_categories
    @root_categories = Category.root_categories
    @sub_categories = Category.sub_categories(2)
    @sub_categories_two = Category.sub_categories(3)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def promo_params
    params.require(:promo).permit(:name, :description, :extra_description, :place_id, :published, :start_at, :end_at, :role_id, :place_id, :banner, :star_number, :category_id, :subcategory1_id, :subcategory2_id)
  end
end
