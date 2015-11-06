class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception #, :if => Proc.new { |c| c.request.format == 'application/json' }
  before_action :set_locale

  # rescue_from CanCan::AccessDenied do |exception|
  #   respond_to do |format|
  #     format.json { error_response }
  #   end
  # end

  def after_sign_in_path_for(resource)
    if resource.business_user? && resource.has_a_free_subscription_active?
      subscriptions_path
    else
      search_promos_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: exception.message
    # render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

  protected

    def set_locale
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
      locale = I18n.default_locale
      unless params[:locale].nil?
        unless params[:locale].empty?
          locale = params[:locale] || I18n.default_locale
        end
      end
      I18n.locale = locale
      Rails.application.routes.default_url_options[:locale]= I18n.locale
    end

end
