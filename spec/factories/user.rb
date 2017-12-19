FactoryGirl.define do
  factory :user do
    email "test@test.com"
    first_name "Test_first_name"
    last_name "Test_last_name"
    password "password"
    confirmed_at Time.now
  end
end
