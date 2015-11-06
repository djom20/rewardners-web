module Rewardners
  module V1
    class Categories < Grape::API

      namespace :categories do

        before do
          authenticate!
        end

        get do
          success_response Category.get_tree_structure, 200
        end

      end

    end
  end
end
