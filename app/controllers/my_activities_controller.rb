class MyActivitiesController < ApplicationController
  def index
  	@activities = Activity.available_activities(current_user)
  end
end
