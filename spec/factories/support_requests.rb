FactoryGirl.define do
  factory :support_request do
    name "Joe Tester"
    email "test@test.com"
    subject "A subject here"
    message "A message in the request"
    completed false
  end
end
