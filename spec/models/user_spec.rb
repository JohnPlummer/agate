require 'spec_helper'

describe User do

	it { should validate_presence_of :username }
	it { should validate_presence_of :email }
	it { should validate_presence_of :password }
	it { should ensure_length_of(:username).
			            is_at_least(2).
			            is_at_most(20) }
	it { should ensure_length_of(:password).
			            is_at_least(6).
			            is_at_most(20) }


	context "already in database" do

		before do
			user = Factory.build(:user)
			user.skip_confirmation!
			user.save
		end

		it { should validate_uniqueness_of(:username).case_insensitive }

	end

	context "from factory" do
		before(:each) do
			@user = Factory.build(:user, :username       => 'Fred',
			                      :email                 => 'fred@foo.bar',
			                      :password              => 'password',
			                      :password_confirmation => 'password')
		end

		specify { @user.should be_valid }
		specify { @user.display_username.should == 'Fred' }
		specify { @user.username.should == 'fred' }

		it "is not valid without matching password and password confirmation" do
			@user.password_confirmation = 'not password'
			@user.should be_invalid
		end

	end

end
