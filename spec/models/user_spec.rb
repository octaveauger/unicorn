require 'spec_helper'

describe User do

	before do
		@user = User.new(email: "test@test.com", password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:reset_password_token) }
	it { should respond_to(:reset_password_sent_at) }
	it { should respond_to(:remember_created_at) }
	it { should respond_to(:sign_in_count) }
	it { should respond_to(:current_sign_in_at) }
	it { should respond_to(:last_sign_in_at) }
	it { should respond_to(:current_sign_in_ip) }
	it { should respond_to(:last_sign_in_ip) }

	it { should be_valid }

	describe "without an email" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "with invalid email" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
			addresses.each do |invalid_address|
		        @user.email = invalid_address
		        expect(@user).not_to be_valid
	      end
	    end
	end

	describe "when email is already taken" do
		before do
			other_user = @user.dup
			other_user.save
		end
		it { should_not be_valid }
	end

	describe "without a password" do
		before do
			@user = User.new(email: "test@test.com", password: " ", password_confirmation: " ")
		end
		it { should_not be_valid }
	end		

	describe "when password is too short" do
		before { @user.password = "a" * 5 }
		it { should_not be_valid }
	end

#Issue: no authenticate method in Devise... To be fixed
<<-DOC
	describe "password authentication" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }

		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:wrong_user) { found_user.authenticate("invalid") }
			it { should_not eq wrong_user }
			specify { expect(wrong_user).to be_false }
		end
	end
DOC

end
