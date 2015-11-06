module Rewardners
  module V1
    class Places < Grape::API

      namespace :places do

        before do
          authenticate!
        end

        get 'stars' do
          @places = Place.get_available_stars_for_user @current_user
          places = @places.map{|place| {id: place["place_id"], name:  place["name"], stars: place["total_stars"]} }
          success_response places, 200
        end

        get :favorites, each_serializer: PlaceSerializer do
          success_response Place.get_liked_places_for_user(@current_user).paginate(per_page: params[:per_page], page: params[:page]), 200
        end

        # ********* D I S C O V E R *********
        get :discover, each_serializer: PlaceSerializer do
          success_response Place.find_for_user_with_criteria(@current_user, params[:criteria]).paginate(per_page: params[:per_page], page: params[:page]), 200
        end

        # ********* L I K E *********
        params do
          requires :id, type: Integer
        end
        post ':id/like' do
          @place = Place.find(params[:id])
          if @current_user.like!(@place)
            success_response
          else
            error_response
          end
        end


        # ********* U N L I K E *********
        params do
          requires :id, type: Integer
        end
        delete :unlike do
          @place = Place.find(params[:id])
          if @current_user.unlike!(@place)
            success_response
          else
            error_response
          end
        end

        # ********* P L A C E    I N F O *********
        params do
          requires :id, type: Integer
        end
        get ":id/info", each_serializer: CompletePlaceSerializer do
          unless (@place = Place.first(params[:id])).nil?
            return success_response @place, 200
          end
          error_response
        end

        get :owned, each_serializer: PlaceSerializer do
          success_response current_user.places.paginate(per_page: params[:per_page], page: params[:page]), 200
        end

      end

    end
  end
end
