Given /^I am not signed in$/ do
	visit('/users/sign_out')
end

Given /^I am a registered user$/ do
	@user = Factory.build(:user)
	@user.skip_confirmation!
	@user.save!
end

Then /^a new user should get created with the following details:$/ do |table|
	expected = User.new table.hashes.first
	@user    = User.find_by_username(expected.username.downcase)
	@user.email.should == expected.email
end

