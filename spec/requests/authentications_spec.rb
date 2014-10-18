require 'spec_helper'

describe "Authentications" do

	describe "the static pages" do

		subject { page }

		describe "for signed in users" do

			let(:logged_in_user) { FactoryGirl.create(:user) }
			before do
				sign_in logged_in_user
				visit root_path
			end

			it { should_not have_link("Log in", href: new_user_session_path) }
			it { should_not have_link("Sign up", href: new_user_registration_path) }
			it { should have_link("Log out", href: destroy_user_session_path) }

			describe "followed by sign out" do
				before { click_link "Log out"}

				it { should have_link("Log in", href: new_user_session_path) }
				it { should have_link("Sign up", href: new_user_registration_path) }
				it { should_not have_link("Log out", href: destroy_user_session_path) }
			end
		end

	end

end
