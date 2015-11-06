module Rewardners
  module V1
    class Users < Grape::API

      namespace :users do
        params do
          requires :user, :type => Hash do
            requires :name
            requires :last_name
            requires :email
            requires :city
            requires :zipcode
            requires :password
            requires :password_confirmation
            requires :terms
          end
        end
        post do
          @user = User.new(params[:user])
          @user.signup_type = params[:user][:signup_type]
          @user.terms = params[:user][:terms]
          if @user.save
            success_response @user
          else
            error_response @user.errors
          end
        end

        params do
          requires :user, :type => Hash
        end
        put ":id" do
          @user = User.find(params[:id])
          params[:user].delete("authentication_token")
          params[:user].delete("role")
          params[:user].delete("roles")
          params[:user].delete("fullname")
          params[:user].delete("full_name")
          if @user.update(params[:user])
            success_response @user
          else
            error_response @user.errors
          end
        end

        params do
          requires :user, :type => Hash do
            requires :email
          end
        end
        post 'reset/password' do
          unless (user=User.where(email: params[:user][:email]).first).nil?
            user.send_reset_password_instructions
            success_response
          else
            error_response
          end
        end

        get 'redeems' do
          authenticate!
          redeems = Redeem.get_redeems_for_user(@current_user).order("created_at asc")
          _redeems = redeems.map{|r| {id: r.id, place:{name:  r.place.name, id: r.place.id}, stars: r.number_of_stars, created_at: r.created_at} }
          success_response _redeems
        end

      end

    end
  end
end
