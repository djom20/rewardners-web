class HomeController < ApplicationController

  layout 'landing', only: [:landing, :business]

  def index
    if user_signed_in?
      redirect_to search_promos_path
    else
      redirect_to landing_path
    end
  end

  def landing
  end

  def business
  end

  def terms
  end

  def about_us
  end

  def legal
  end

  def faq
  end

  def pricing
  end

  def bring_rewardners_to_your_city
  end

  def join_rewardners
  end

  def local_projects
  end

  def rewardners_international
  end

end
