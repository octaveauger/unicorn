class AdminActivitiesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @activities = Activity.all.paginate(page: params[:page])
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      flash[:notice] = "New activity created!"
      redirect_to admin_activities_path
    else
       flash[:alert] = "Your new activity contains errors"
     render 'new'
    end
  end

  def destroy
    Activity.find(params[:id]).destroy
    flash[:notice] = "Activity deleted!"
    redirect_to admin_activities_path
  end

  def edit
    @activity = Activity.find_by(id: params[:id])
    if @activity.nil?
      flash[:alert] = "This activity wasn't found"
      redirect_to admin_activities_path
    end
  end

  def update
    @activity = Activity.find_by(id: params[:id])
    if @activity.update_attributes(activity_params)
      flash[:notice] = "Activity successfully updated"
      redirect_to admin_activities_path
    else
      flash[:alert] = "There were errors updating your activity"
      render 'edit'
    end
  end

  private

    def activity_params
      params.require(:activity).permit(:name, :description, :creator_id, :is_public, :is_live)
    end

end
