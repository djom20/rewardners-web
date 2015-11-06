class TakenPromosController < ApplicationController

  before_action :set_taken_promo, except: [:index]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @taken_promos = TakenPromo.get_taken_promos_for_user_places(current_user).paginate(page: params[:page], per_page: 10)
  end

  # Bussiness user accept or reject promos orders
  # =============================================

  def accept
    respond_to do |format|
      if @taken_promo.accept current_user
        @taken_promo.create_activity :accept, owner: current_user, recipient: @taken_promo.user
        format.js { render partial: "taken_promos/actions/update_promo_actions", locals: { taken_promo: @taken_promo} }
      else
        format.js { }
      end
    end
  end

  def reject
    respond_to do |format|
      if @taken_promo.reject current_user
        @taken_promo.create_activity :reject, owner: current_user, recipient: @taken_promo.user
        format.js { render partial: "taken_promos/actions/update_promo_actions", locals: { taken_promo: @taken_promo} }
      else
        format.js { }
      end
    end
  end

  private

  def set_taken_promo
    @taken_promo = TakenPromo.find(params[:id])
  end

end
