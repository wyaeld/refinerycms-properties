
FactoryGirl.define do
  factory :property, :class => Refinery::Properties::Property do
    sequence(:region) { |n| "refinery#{n}" }
  end
end

