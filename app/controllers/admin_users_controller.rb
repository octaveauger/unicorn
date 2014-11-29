class AdminUsersController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
  	@users = User.all.paginate(page: params[:page])
  end

  def edit
  	@user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "This user wasn't found"
      redirect_to admin_users_path
    end
  end

  def update
  	@user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "User successfully updated"
      redirect_to admin_users_path
    else
      flash[:alert] = "There were errors updating this user"
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :admin)
    end

end
