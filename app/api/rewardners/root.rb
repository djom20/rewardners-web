module Rewardners
  class Root < Grape::API

    prefix :api
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    helpers do

      def error_response errors = nil, status_code = 406
        status status_code
        return error!(errors) unless errors.nil?
      end

      def success_response data = nil, status_code = 200, extra_headers = nil
        status status_code
        return if data.nil?
        # Encapsule in array a single object, ensure to response arrays in every request
        final_data = data.class.ancestors.include?(ActiveRecord::Base) ? [data] : data
        # Apply extra header params
        unless extra_headers.nil?
          return final_data, {:meta => extra_headers, meta_key: "x-api-extra"}
        end
        return final_data
      end

      def authorize!(*args)
        ::Ability.new(@current_user).authorize!(*args)
      end

      def authenticate!
        error_response ['Unauthorized. Invalid or expired token.'], 401 unless current_user
      end

      def authenticate_business!
        error_response ['Unauthorized. Invalid or expired token.'], 401 unless current_user && current_user.business_user?
      end

      def current_user
        token = headers['X-User-Token']
        if token && @current_user = User.find_by(authentication_token: token)
          return @current_user
        end
        return false
      end


    end

    mount Rewardners::V1::Root

  end
end
