FactoryGirl.define do
  factory :group do
    name "Girl's Group"
    sequence :id do |n|
      "#{n}"
    end
  end
end