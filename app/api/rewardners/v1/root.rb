module Rewardners
  module V1
    class Root < Grape::API

      version 'v1'

      mount Rewardners::V1::Sessions
      mount Rewardners::V1::Promos
      mount Rewardners::V1::Users
      mount Rewardners::V1::Categories
      mount Rewardners::V1::Places
      mount Rewardners::V1::TakenPromos
      mount Rewardners::V1::Roles
      mount Rewardners::V1::Redeems
    end
  end
end
