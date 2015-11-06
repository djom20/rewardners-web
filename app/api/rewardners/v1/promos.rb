module Rewardners
  module V1
    class Promos < Grape::API

      namespace :promos do

        before do
          authenticate!
        end

        get :trendings, each_serializer: PromosSerializer do
          success_response Promo.get_promos_for_user(@current_user), 200
        end

        get :processed, each_serializer: TakenPromoSerializer, root: :takens do
          success_response TakenPromo.get_taken_promos_for_user(@current_user), 200
        end

        get :taken, each_serializer: PromosSerializer do
          success_response Promo.get_taken_promos_for_user(@current_user), 200
        end


        get :search, each_serializer: PromosSerializer do
          criteria = params.has_key?(:criteria) ? params[:criteria] : ""
          results = Promo.search_user_promos @current_user, criteria, params[:categories]
          # results = Promo.get_promos_by_zipcode(criteria) if results.empty?

          success_response results
        end


        get :public_search, each_serializer: PromosSerializer do
          criteria = params[:criteria] || ""
          success_response Promo.get_promos_for_user_with_filters @current_user, categories, criteria
        end



        get :favorites, each_serializer: PromosSerializer do
          success_response Promo.get_promos_based_on_liked_places_for_user current_user
        end

        # -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
        # Tomar una promoción vigente
        # -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
        post ":promo_id/take", each_serializer: PromosSerializer do
          if @promo = Promo.get_promo(params[:promo_id])
            if @promo.take_promo! @current_user
              return success_response, @promo
            end
          end
          error_response
        end

        # -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
        # Cancelar el tomar una promoción
        # -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
        delete ":promo_id/untake", each_serializer: PromosSerializer do
          if @promo = Promo.get_promo(params[:promo_id])
            if @promo.untake_promo! @current_user
              return success_response, @promo
            end
          end
          error_response
        end

        params do
          requires :place_id
        end
        get :by_place, each_serializer: PromosSerializer do
          @place = Place.find(params[:place_id])
          @promos = @place.promos.all.includes(:role)
          success_response @promos
        end

        # params do
        #   requires :promo
        # end
        post :/, each_serializer: PromosSerializer do
          unless current_user.can_create_promos?
            error_response ['The user is unable to create new promos.']
          end
          @promo = Promo.new(params[:promo])
          @promo.created_via_api = true

          # TODO fix this
          category = Category.first
          @promo.category_id = category.id
          @promo.subcategory1_id = category.subcategories.first.id

          if @promo.save
            success_response @promo
          else
            error_response @promo.errors.full_messages.to_sentence, 400
          end
        end

        params do
          requires :promo
        end
        put "/:promo_id", each_serializer: PromosSerializer do
          unless @promo = Promo.find(params[:promo_id])
            error_response ['The user is unable to create new promos.'], 404
          end
          if @promo.update(params[:promo])
            success_response @promo
          else
            error_response @promos.errors.full_messages
          end
        end

      end

    end
  end
end
