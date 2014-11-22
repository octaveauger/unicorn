class MyActivitiesController < ApplicationController
  def index
  	@activities = current_user.user_activities.visible
  end

  def transition
  	activity = current_user.user_activities.find(params[:user_activity_id])
  	activity.state_machine.trigger!(:toggle)
  	@activities = current_user.user_activities.visible
  	respond_to do |format|
  		format.json { render json: @activities }
  	end
  end
end
