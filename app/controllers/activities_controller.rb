class ActivitiesController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def new
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

    def activity_params
      params.require(:activity).permit(:name, :description, :creator_id, :is_public, :is_live)
    end

end
