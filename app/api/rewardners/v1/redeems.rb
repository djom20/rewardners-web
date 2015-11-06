module Rewardners
  module V1
    class Redeems < Grape::API

      namespace :redeems do

        before do
          authenticate!
        end

        # get :/,  each_serializer: RedeemSerializer do
        #   success_response Redeem.get_redeems_for_locals_with_user(current_user), 200
        # end

        params do
          requires :redeem
        end
        post :/, each_serializer: RedeemSerializer do 
          unless current_user.has_a_subscription_payed_active?
            error_response ['The user is unable to create new reedems.']
          end
          @reedem = Redeem.new(params[:redeem])
          if @reedem.save
            success_response @reedem
          else
            error_response @reedem.errors.full_messages.to_sentence, 400
          end
        end

        # TODO find a better implementation of this (a class for the results)
        get :pending do
          @result = Place.get_available_stars_for_places_for_user(current_user, 
            params[:user_search_code]).map{|stu| 
              {
                user_name: stu["user_name"].present? ? "#{stu['user_name']} #{stu['user_last_name']}" : "#{stu['user_business_name']}", 
                user_email: stu["user_email"], place_name: stu["name"], 
                stars: stu["total_stars"], place_id: stu["place_id"], 
                user_id: stu["user_id"]
              }
            }
          success_response @result, 200
        end

      end

    end
  end
end