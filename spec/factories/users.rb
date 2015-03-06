# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  sequence :username do |n|
      "John#{n}"
  end
  sequence :id do |n|
    "#{n}"
  end
  sequence :email do |n|
    "john#{n}@bla.com"
  end
  password "clip3333"
  password_confirmation "clip3333"
end
end
