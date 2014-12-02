class Activity < ActiveRecord::Base
	after_initialize :default_values
	validates :name, presence: true, length: { maximum: 20 }
	validates :description, presence: true, length: { maximum: 100 }
	has_many :user_activities, dependent: :destroy
	scope :visible_to_all, -> { where(is_public: true, is_live: true) }

	def default_values
		self.is_public = true if self.is_public.nil?
		self.is_live = true if self.is_live.nil?
	end

	def self.available_activities(user)
		Activity.where(creator_id: [nil, user.id], is_public: true, is_live: true)
	end

end
