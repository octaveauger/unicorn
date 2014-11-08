class Activity < ActiveRecord::Base
	after_initialize :default_values

	validates :name, presence: true, length: { maximum: 20 }
	validates :description, presence: true, length: { maximum: 100 }

	def default_values
		self.is_public = true if self.is_public.nil?
		self.is_live = true if self.is_live.nil?
	end
end
