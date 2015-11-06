class Users::RegistrationsController < Devise::RegistrationsController

  private

    def sign_up_params
      params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :zipcode, :business_name, :signup_type, :address, :city, :manager, :phone, :terms)
    end

    def account_update_params
      params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :business_name, :signup_type, :address, :zipcode, :city, :manager, :phone, :avatar)
    end

  protected

    def after_inactive_sign_up_path_for(resource)
      welcome_users_path
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def after_update_path_for(resource)
      user_path(resource)
    end

end
