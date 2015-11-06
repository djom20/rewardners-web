module Rewardners
  module V1
    class Roles < Grape::API

      namespace :roles do

        before do
          authenticate!
        end

        get :/,  each_serializer: RolesSerializer do
          success_response Role.all_without_admin, 200
        end

      end

    end
  end
end