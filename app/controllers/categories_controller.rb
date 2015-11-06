class CategoriesController < ApplicationController

  before_action :get_parent
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_new_category, only: [:create]
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html

  def index
    @categories = (!@parent.nil? ? @parent.categories : Category.root_categories).order("created_at desc")
  end

  def show
  end

  def new
    @category = !@parent.nil? ? @parent.categories.new : Category.new
  end

  def edit
  end

  def create
    if @category.save
      redirect_to @category, notice: I18n.t('controllers.categories.create')
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: I18n.t('controllers.categories.update')
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: I18n.t('controllers.categories.destroy')
  end

  def subcategories
    category_selected = Category.find(params[:category_id])
    @subcategories ||= category_selected.subcategories_by_level(params[:level])
    @selector = params[:selector]
    @locale = params[:locale]
    @prompt_subcategory = I18n.t('views.promos.prompt_subcategory')
    respond_to do |format|
      format.js {}
    end
  end

  private

  def get_parent
    category_id = nil
    if params.has_key?(:category_id)
      category_id = params[:category_id].empty? ? nil : params[:category_id]
    elsif params.has_key?(:category)
      category_id = params[:category][:category_id].empty? ? nil : params[:category][:category_id]
    end
    @parent = !category_id.nil? ? Category.find(category_id) : nil
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = !@parent.nil? ? @parent.categories.find(params[:id]) : Category.find(params[:id])
  end

  def set_new_category
    @category = !@parent.nil? ? @parent.categories.new(category_params) : Category.new(category_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name, :description, :icon, :category_type, :category_id)
  end

end
