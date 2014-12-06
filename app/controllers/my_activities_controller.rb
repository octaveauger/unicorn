class MyActivitiesController < ApplicationController
  before_action :logged_in_user

  def index
  	@activities = current_user.user_activities.available
    @started_transition = UserActivity.current_started_transition(current_user)
  end

  def transition
  	activity = current_user.user_activities.find(params[:user_activity_id])
  	activity.state_machine.trigger!(:toggle)
  	@activities = current_user.user_activities.visible
  	respond_to do |format|
  		format.json { render json: @activities }
  	end
  end

  def customise
    @activities = current_user.user_activities.all
  end

  def update
    @activity = UserActivity.find_by(id: params[:id])
    if @activity.update_attributes(user_activity_params)
      respond_to do |format|
        format.json { render json: @activity }
      end
    else
      respond_to do |format|
        format.json { render json: 'error - impossible to update' }
      end
    end
  end

  private

    def user_activity_params
      params.require(:user_activity).permit(:is_displayed)
    end
end
