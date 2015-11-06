module Rewardners
  module V1
    class TakenPromos < Grape::API

      namespace :taken_promos do

        before do
          authenticate!
        end

        get :pending_approval, each_serializer: TakenPromoSerializer do
          @taken_promos = TakenPromo.get_taken_promos_for_user_places(current_user)
          success_response @taken_promos, 200
        end

        params do
          requires :promo_code
        end
        get :promo_code_search, each_serializer: TakenPromoSerializer do
          @taken_promo = TakenPromo.get_taken_promos_for_user_places(current_user).find_by(promo_code: params[:promo_code])
          if @taken_promo
            success_response @taken_promo, 200
          else
            error_response "taken promo not found", 404
          end
        end

        params do
          requires :accepted
        end
        post ":id/resolve", each_serializer: TakenPromoSerializer do
          authenticate_business!
          @taken_promo = TakenPromo.find(params[:id])
          if @taken_promo
            if params[:accepted] == "true"
              @taken_promo.accept(current_user)
            else
              @taken_promo.reject(current_user)
            end
            if @taken_promo.valid?
              success_response @taken_promo, 200
            else
              error_response @taken_promo.errors.full_messages
            end
          #TODO not_founds in general should be handle by try-catch's
          end
          
        end

      end

    end
  end
end
