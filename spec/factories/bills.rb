FactoryGirl.define do
  factory :bill do
    amount 1
    sequence :id do |n|
      "#{n}"
    end
  end
end