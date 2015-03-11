FactoryGirl.define do
  factory :expense_calculator do
    initialize_with { new(group) }
  end
end