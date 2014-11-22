class Activity < ActiveRecord::Base
	after_initialize :default_values
	validates :name, presence: true, length: { maximum: 20 }
	validates :description, presence: true, length: { maximum: 100 }
	has_many :user_activities, dependent: :destroy

	after_save :update_user_activity_visibility

	def default_values
		self.is_public = true if self.is_public.nil?
		self.is_live = true if self.is_live.nil?
	end

	def self.available_activities(user)
		Activity.where(creator_id: [nil, user.id], is_public: true, is_live: true)
	end

	private
		
		#Make sure that changes to an activity that affect visibility are reflected in user_activities
		def update_user_activity_visibility
			if !self.is_public? || !self.is_live?
				self.user_activities.update_all(:is_displayed => false)
			end
		end
end
