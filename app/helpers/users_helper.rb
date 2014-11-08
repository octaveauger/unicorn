module UsersHelper

	def logged_in_user
		redirect_to new_user_session_path, notice: "Please notice first" unless current_user
	end

	def admin_user
		redirect_to root_path, notice: "Unauthorised access" unless current_user && current_user.admin
	end

	def admin_user?
		current_user ? current_user.admin : false
	end
end
