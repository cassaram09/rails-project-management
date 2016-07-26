# This will guess the User class
FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    role :user
  end

  factory :admin, class: User do
    first_name "Admin"
    last_name  "User"
    role :admin
  end
end