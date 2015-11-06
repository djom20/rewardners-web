class ActivitiesController < ApplicationController
  helper ActivitiesHelper
  before_action :initialize_activities

  def index
    @activities.update_all(status: Activity::VIEWED)
  end

  def tiny_index
    @activities_count = @activities.where(status: [Activity::NO_VIEWED, nil]).count
    @activities = @activities.where(status: [Activity::NO_VIEWED, nil]).limit(5)
    respond_to do |format|
      format.js
    end
  end

  private
    def initialize_activities
      @activities = PublicActivity::Activity.includes(:owner).order("created_at desc").where("trackable_id IS NOT NULL").where(recipient_id: current_user.id).includes(:trackable)
    end
end
