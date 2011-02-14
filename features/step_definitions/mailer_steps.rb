Then /^I should receive an email with the following details:$/ do |table|
	expected = table.hashes.first
	email    = ActionMailer::Base.deliveries.first
	email.should_not == nil
	email.to.should include @user.email
	email.subject.should include expected[:subject]
	email.body.should include expected[:body]
end