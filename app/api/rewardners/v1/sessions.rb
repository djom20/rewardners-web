module Rewardners
  module V1
    class Sessions < Grape::API

      namespace :sessions, each_serializer: SessionSerializer do
        params do
          requires :user, :type => Hash do
            requires :email
            requires :password
          end
        end
        post do
          @user = User.find_for_authentication(email: params[:user][:email])
          if @user.nil? or not @user.valid_password?(params[:user][:password])
            return error_response
          end
          @user.generate_auth_token!
          return success_response @user, 202
        end

        before do
          authenticate!
        end
        delete do
          @current_user.remove_auth_token!
          return success_response @user, 202
        end
      end

    end
  end
end
